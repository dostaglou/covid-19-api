class LineBotController < ApplicationController
  protect_from_forgery :except => [:callback]

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"] || Rails.application.secrets.line[:channel_secret]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"] || Rails.application.secrets.line[:channel_token]
    }
  end

  def broadcast(id:, content:)

    message = {
      type: "text",
      text: content
    }
    response = client.push_message(id, message)
  end

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head :bad_request
    end

    events = client.parse_events_from(body)
    events.each do |event|
      case event.type
      when Line::Bot::Event::MessageType::Text
        @user_id = event["source"]["userId"]
        response = client.get_profile(@user_id)

        case response
        when Net::HTTPSuccess
          contact = JSON.parse(response.body)
          @username = contact["displayName"]
          @line_user = User.find_or_initialize_by(line_id: @user_id)
          if !@line_user.line_signed_up
            @line_user.attributes = { line_id: @user_id,
                                      line_name: @username,
                                      line_notifications: true,
                                      line_deleted_at: nil }
            @line_user.save
          end
        end

        if event.message["text"]
          content = text_message_builder(event.message["text"])
          message = {
            type: "text",
            text: content
          }
          client.reply_message(event["replyToken"], message)
        end
      end
    end

    head :ok
  end


  def text_message_builder(message)
    # TOO LONG
    if message.length > 50
      message_unclear

    # HELP
    elsif message_help(message: message, analyze: true)
      message_help(message: message, analyze: false)

    # SIGNUP
    elsif message_signup(message: message, analyze: true)
      message_signup(message: message, analyze: false)

    # DELETE
    elsif message_delete(message: message, analyze: true)
      message_delete(message: message, analyze: false)

    # TURN-OFF
    elsif message_turn_off(message: message, analyze: true)
      message_turn_off(message: message, analyze: false)

    # UPDATE-COUNTRY (Notification)
    elsif message_update_country(message: message, analyze: true)
      message_update_country(message:message, analyze: false)

    # UPDATE-TIME (Notification)
    elsif message_update_time(message: message, analyze: true)
      message_update_time(message: message, analyze: false)

    # LIST
    elsif message_x_country_list(message: message, analyze: true)
      message_x_country_list(message: message, analyze: false)

    # DATA
    elsif country_name_resolver(message: message)
      message_country_data(message: message)

    # FALLBACK
    else
      message_unclear
    end
  end

  def message_help(message:, analyze:)
    if analyze
      /(help)/i.match(message)
    else
    "The list of options are: \n" +
    "1) Type 1 country name (capitalized) to get info on it. Ex: Japan, USA, UK. \n" +
    "2) Type LETTER-countries to get a list of those countries. Ex: j-countries. \n" +
    "3) Type Signup to get daily (9am JST) notifications about a single coutnry. \n" +
    "4) Type HOUR:MINUTES to change notification time. Must be in half-hour increments. Ex: 09:30, 23:00. All times in GMT \n" +
    "5) Type Turn-Off to remove daily notifications. \n" +
    "6) Type Delete to delete your account. \n"
    end
  end

  def message_signup(message:, analyze:)
    if analyze
      /(signup)/i.match(message) || /(sign up)/i.match(message)
    else
      if @username && @user_id
        user = User.find_or_initialize_by(line_id: @user_id)
        user.attributes = { line_id: @user_id,
                            line_name: @username,
                            line_notifications: true,
                            line_deleted_at: nil,
                            line_signed_up: true }
        user.save
        "You have been added. Please respond with COUNTRY-update. \n" +
        "This will enable daily notifications about that country for you. \n" +
        "You may update your choice at any time by re-texting COUNTRY-update."
      else
        "I am sorry, there has been an error. \n" +
        "Please try again later or contact my master"
      end
    end
  end

  def message_delete(message:, analyze:)
    if analyze
      /(delete)/i.match(message)
    else
      if @user_id &&  user = User.where(line_deleted_at: nil).find_by(line_id: @user_id)
        user.update(line_deleted_at: DateTime.now)
        "Account deleted"
      else
        "No account found"
      end
    end
  end

  def message_turn_off(message:, analyze:)
    if analyze
      /(turn-off)/i.match(message) || /(turn off)/i.match(message)
    else
      if @user_id && user = User.find_by(line_id: @user_id)
        user.update(line_notifications: false)
        "Your notifications have been turned off. \n" +
        "Thank you and stay safe!"
      else
        "I am sorry, you must sign up to access this feature."
      end
    end
  end

  def message_update_country(message:, analyze:)
    if analyze
      /\w+(-update)/i.match(message)
    else
      if @user_id && user = User.where(line_deleted_at: nil).find_by(line_id: @user_id)
        country = /\w+(-update)/i.match(message).to_s.split("-")&.first
        if country = country_name_resolver(message: country)
          user.update(line_countries: country)
          "Updated. You will now be notified about #{country} about #{user.line_update_time}"
        else
          "I am sorry, #{country} doesn't exist in my database. \n" +
          message_x_country_list(letter: country.first, analyze: false, message: nil)
        end
      else
        "I am sorry. \n" +
        "You must sign up to use this feature. \n" +
        "Text Help to learn more."
      end
    end
  end

  def message_update_time(message:, analyze:)
    return false unless @user_id
    if analyze
      return false unless t = /(\d{0,2}:\d{0,2})/.match(message)
      h, m = t.to_s.split(':')
      h.to_i.between?(0, 24) && m.to_i.between?(0, 60) ? true : false
    else
      if user = User.where(line_deleted_at: nil).find_by(line_id: @user_id)
        time_string = /(\d{0,2}:\d{0,2})/.match(message).to_s
        time = time_string.to_time
        minute = (time.min - (time.min % 30)) == 0? "00" : "30"
        hour = time.hour.to_s
        time_slot = hour + ":" + minute
        user.update(line_update_time: time_slot, line_notifications: true)
        "Updated.\n" +
        "You will be notified about #{user.line_countries} around #{user.line_update_time} GMT (+9h for Japan, -4h NYT)"
      else
        "You must sign up to use this feature"
      end
    end
  end

  def message_x_country_list(message:, analyze:, letter: nil)
    if analyze
      /\w(-countries)/i.match(message)
    else
      letter = /\w(-countries)/i.match(message).to_s.first unless letter
      countries = Country::COUNTRY_NAMES.select { |c| c.starts_with?(letter.upcase)}
      if countries.length > 0
        "There are #{countries.length} countries avalable starting with #{letter.upcase}. \n" +
        "They are:  " +
        "#{countries.join(', ')}. \n" +
        "Please note that country names are case sensitive."
      else
        "There are no countries starting with #{letter.upcase}."
      end
    end
  end

  def message_country_data(message:)
    country = country_name_resolver(message: message)

    single_country_info(country)
  end

  def message_unclear
    "I am sorry. I do not not understand. Please text help for a list of options"
  end

  def country_name_resolver(message:)
    country = Country::COUNTRY_NAMES.find { | c | message.upcase.include?(c.upcase) }
  end

  def single_country_info(country)
    entry = CovidDaily.where(country_name: country )
                      .order(created_at: :desc)
                      .limit(1)
                      .first
    entry.country.update(line_request_count: entry.country.line_request_count + 1)
    "Information for #{country}: \n" +
    "Total Cases: #{entry.total_cases} - Total Deaths: #{entry.total_deaths} \n" +
    "Recovered: #{entry.recovered} - Active: #{entry.active} \n" +
    "24h prior to data collection (#{entry.updated}): \n" +
    "New Cases #{entry.today_cases} - New Deaths #{entry.today_deaths}"
  end

  # RAKE -------------------------------
  def line_broadcast_update(users)
    users.each do |user|
      id = user.line_id
      content = single_country_info(user.line_countries)
      content += "\n\nYou may turn off these notifications by testing turn-off"
      broadcast(id: id, content: content)
    end
  end
end

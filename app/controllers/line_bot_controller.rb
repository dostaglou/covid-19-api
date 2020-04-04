class LineBotController < ApplicationController
  protect_from_forgery :except => [:callback]

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"] || Rails.application.secrets.line[:channel_secret]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"] || Rails.application.secrets.line[:channel_token]
    }
  end

  def broadcast

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
    if /(help)/i.match(message)
      message_help
    elsif /(signup)/i.match(message)
      message_signup
    elsif /(delete)/i.match(message)
      message_delete
    elsif /(turn-off)/i.match(message)
      message_turn_off
    elsif /\w+(-update)/i.match(message)
      message_update_country(/\w+(-update)/i.match(message).to_s.split("-")&.first)
    elsif /\w(-countries)/i.match(message)
      message_x_country_list(/\w(-countries)/i.match(message).to_s.first)
    elsif (message.gsub(/\W/, ' ').split(' ') & Country::COUNTRY_NAMES).length > 0
      message_country_data((message.gsub(/\W/, ' ').split(' ') & Country::COUNTRY_NAMES).first)
    else
      message_unclear
    end
  end

  def message_help
    "The list of options are: \n" +
    "1) Type 1 country name (capitalized) to get info on it. Ex: Japan, USA, UK. \n" +
    "2) Type LETTER-countries to get a list of those countries. Ex: j-countries. \n" +
    "3) Type Signup to get daily (9am JST) notifications about a single coutnry. \n" +
    "4) Type Turn-Off to remove daily notifications. \n" +
    "5) Type Delete to delete your account. \n"
  end

  def message_unclear
    "I am sorry. I do not not understand. Please text help for a list of options"
  end

  def message_turn_off
    if @user_id && user = User.find_by(line_id: @user_id)
      user.update(line_notifications: false)
      "Your notifications have been turned off. \n" +
      "Thank you and stay safe!"
    else
      "I am sorry, you must sign up to access this feature."
    end
  end

  def message_delete
    if @user_id &&  user = User.where(line_deleted_at: nil).find_by(line_id: @user_id)
      user.update(line_deleted_at: DateTime.now)
      "Account deleted"
    else
      "No account found"
    end
  end

  def message_x_country_list(letter)
    countries = Country::COUNTRY_NAMES.select { |c| c.starts_with?(letter.upcase)}
    if countries.length > 0
      "There are #{countries.length} countries avalable starting with #{letter.upcase}. \n" +
      "They are:  " +
      "#{countries.join(', ')}. \n" +
      "Please note that country names are case sensitive"
    else
      "There are no countries starting with #{letter.upcase}."
    end
  end

  def message_country_data(country)
    entry = CovidDaily.where(country_name: country )
                      .order(created_at: :desc)
                      .limit(1)
                      .first
    "Informaiton for #{country}: \n" +
    "Total Cases: #{entry.total_cases} - Total Deaths: #{entry.total_deaths} \n" +
    "Recovered: #{entry.recovered} - Active: #{entry.active} \n" +
    "24h prior to data collection (#{entry.updated}): \n" +
    "New Cases #{entry.today_cases} - New Deaths #{entry.today_deaths}"
  end

  def message_signup
    if @username && @user_id
      user = User.find_or_initialize_by(line_id: @user_id)
      user.attributes = { line_id: @user_id,
                          line_name: @username,
                          line_notifications: true,
                          line_deleted_at: nil }
      user.save
      "You have been added. Please respond with COUNTRY-update. \n" +
      "This will enable daily notifications about that country for you. \n" +
      "You may update your choice at any time by re-texting COUNTRY-update."
    else
      "I am sorry, there has been an error. \n" +
      "Please try again later or contact my master"
    end

  end

  def message_update_country(country)
    if @user_id && user = User.where(line_deleted_at: nil).find_by(line_id: @user_id)
      if Country::COUNTRY_NAMES.include?(country)
        user.update(line_countries: country)
        "Updated. You will now be notified about #{country}"
      else
        "I am sorry, #{country} doesn't exist in my database. \n" +
        message_x_country_list(country.first)
      end
    else
      "I am sorry. \n" +
      "You must sign up to use this feature. \n" +
      "Text Help to learn more."
    end
  end
end

class LineBotController < ApplicationController
  protect_from_forgery :except => [:callback]

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = Rails.application.secrets.line[:channel_secret] || ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = Rails.application.secrets.line[:channel_token] || ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head :bad_request
    end

    events = client.parse_events_from(body)
    events.each { |event|
      case event.type
      when Line::Bot::Event::MessageType::Text
        user_id = event["source"]["userId"]
        username = ""
        response = client.get_profile(user_id)

        if response == Net::HTTPSuccess
          contact = JSON.parse(response.body)
          username = contact["displayName"]
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
    }

    head :ok
  end


  def text_message_builder(message)
    if /(help)/i.match(message)
      message_help
    elsif /\w(-countries)/.match(message)
      message_x_country_list(/\w(-countries)/.match(message).to_s.first)
    elsif (message.gsub(/\W/, ' ').split(' ') & Country::COUNTRY_NAMES).length > 0
      message_country_data((message.gsub(/\W/, ' ').split(' ') & Country::COUNTRY_NAMES).first)
    else
      message_unclear
    end
  end

  def message_help
    "The list of options are: \n" +
    "1) Type 1 country name (capitalized) to get info on it. Ex: Japan, USA, UK. \n" +
    "2) Type LETTER-countries to get a list of those countries. Ex: j-countries "
  end

  def message_unclear
    "I am sorry. I do not not understand. Please text help for a list of options"
  end

  def message_x_country_list(letter)
    countries = Country::COUNTRY_NAMES.select { |c| c.starts_with?(letter.upcase)}
    if countries.length > 0
      "There are #{countries.length} countries avalable starting with #{letter.upcase}. \n" +
      "They are:  " +
      "#{countries.join(', ')}"
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

end

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
    puts "I am here in the code!



    oh yea"
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head :bad_request
    end

    events = client.parse_events_from(body)

    events.each { |event|
      case event
      when Line::Bot::Event::Message::Text
        user_id = evetn.dig("source", "userId")
        username = ""
        response = client.get_profile(user_id)
        case response
        when Net::HTTPSuccess then contact = JSON.parse(response.body)
          username = contact["displayName"]
        else
          p "#{response.code} #{response.body}"
        end

        if event.message["text"]
          # event.message["text"]&.to_s
          message = {
            type: "text",
            text: "a response"
          }
          client.reply_message(event["replyToken"], message)
        end
      end
    }

    head :ok
  end
end

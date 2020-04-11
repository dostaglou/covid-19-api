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
          line_messeger = LinebotMessage.new(@user_id, @username, @line_user)
          content = line_messeger.text_message_builder(event.message["text"])
          message = {
            type: "text",
            text: content || "sorry"
          }

          client.reply_message(event["replyToken"], message)
        end
      end
    end

    head :ok
  end

  # RAKE -------------------------------
  def line_broadcast_update(users)
    users.each do |user|
      id = user.line_id
      content = LinebotMessage.single_country_info(user.line_countries)
      content += "\n\nYou may turn off these notifications by texting turn-off"
      broadcast(id: id, content: content)
    end
  end
end

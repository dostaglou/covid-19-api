module SlackNotification
  class << self
    WEBHOOK_URL = Rails.application.secrets.webhook
    def hello
      notifier = Slack::Notifier.new WEBHOOK_URL
      msg = "Hello World"

      Slack::Notifier::Util::LinkFormatter.format(msg)

      notifier.post text: msg
    end

    def send_japan_data(data:)
      notifier = Slack::Notifier.new WEBHOOK_URL
      msg = data

      Slack::Notifier::Util::LinkFormatter.format(msg)

      notifier.post text: msg
    end
  end
end

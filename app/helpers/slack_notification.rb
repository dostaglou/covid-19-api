module SlackNotification
  class << self
    WEBHOOK_URL = Rails.application.secrets.webhook || ENV["SLACK_HOOK"]
    def hello
      notifier = Slack::Notifier.new WEBHOOK_URL
      msg = "Hello World"

      Slack::Notifier::Util::LinkFormatter.format(msg)

      notifier.post text: msg
    end

    def send_msg(data:)
      notifier = Slack::Notifier.new WEBHOOK_URL
      msg = data

      notifier.post text: msg
    end
  end
end

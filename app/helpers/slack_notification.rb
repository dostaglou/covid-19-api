module SlackNotification
  class << self
    WEBHOOK_URL = Rails.application.secrets.webhook
    def send_info
      notifier = Slack::Notifier.new WEBHOOK_URL
      msg = "Hello World"
      Slack::Notifier::Util::LinkFormatter.format(msg)
      notifier.post text: msg
    end
  end
end

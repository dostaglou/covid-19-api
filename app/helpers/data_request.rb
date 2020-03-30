module DataRequest
  include HTTParty
  class << self
    BASE_URL = "https://corona.lmao.ninja/countries"
    def request_data
      response = HTTParty.get(BASE_URL)
      parsed = JSON.parse response.body

      msg_japan(parsed)

      return nil
    end

    def msg_japan(parsed)
      japan = parsed.find { |data| data["country"] == "Japan"}

      SlackNotification.send_japan_data(data: japan.to_json)
    end
  end
end

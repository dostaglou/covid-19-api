class TwitterBotController < ApplicationController
  def client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["CONSUMER_KEY"] || Rails.application.secrets.twitter[:consumer_key]
      config.consumer_secret     = ENV["CONSUMER_SECRET"] || Rails.application.secrets.twitter[:consumer_secret]
      config.access_token        = ENV["ACCESS_TOKEN"] || Rails.application.secrets.twitter[:access_token]
      config.access_token_secret = ENV["ACCESS_SECRET"] || Rails.application.secrets.twitter[:access_token_secret]
    end
  end

  def daily_update
    client
    regions = Country::REGIONS
    focus_nations = ["USA", "Canada", "Japan", "Germany", "UK", "France"]
    random = (Country::COUNTRY_NAMES - focus_nations).sample(4)

    regions.each do |x|
      message = TwitterMessage.new.single_region_info(x)
      @client.update(message)
      sleep 3
    end

    sleep 3

    focus_nations.each do |x|
      message = TwitterMessage.new.single_country_info(x)
      @client.update(message)
      sleep 3
    end

    sleep 3

    random.each do |x|
      message = "A random country\n"
      message += TwitterMessage.new.single_country_info(x)
      @client.update(message)
      sleep 3
    end
  end
end

class LinebotMessage
  def initialize(user_id, username, line_user)
    @user_id = user_id
    @username = username
    @line_user = line_user
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

    # AVAILABLE REGIONS
    elsif message_regions(message: message, analyze: true)
      message_regions(message: message, analyze:false)

    # DATA SOURCE
    elsif message_source(message: message, analyze: true)
      message_source(message: message, analyze: false)

    # UPDATE-COUNTRY (Notification)
    elsif message_update_country(message: message, analyze: true)
      message_update_country(message:message, analyze: false)

    # UPDATE-TIME (Notification)
    elsif message_update_time(message: message, analyze: true)
      message_update_time(message: message, analyze: false)

    # LIST
    elsif message_x_country_list(message: message, analyze: true)
      message_x_country_list(message: message, analyze: false)

    # DATA - REGION
    elsif region_name_resolver(message: message)
      message_region_data(message: message)

    # DATA - COUNTRY
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
    "1) Type a country or region name to get info on it. Ex: Japan, USA, East Asia. \n" +
    "2) Type LETTER-countries to get a list of those countries. Ex: j-countries. \n" +
    "3) Type REGIONS to see what regions we currently support \n" +
    "4) Type Signup to get daily (9am JST) notifications about a single coutnry. \n" +
    "5) Type HOUR:MINUTES to change notification time. Must be in half-hour increments. Ex: 09:30, 23:00. All times in GMT \n" +
    "6) Type Turn-Off to remove daily notifications. \n" +
    "7) Type Delete to delete your account. \n" +
    "8) Type source to learn the source for our data \n" +
    "9) Type contact for our email to send feedback. "
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

  def message_regions(message:, analyze:)
    if analyze
      /(regions)/i.match(message) || /(region)/i.match(message)
    else
      "We currently support: #{Country::REGIONS.join(', ')}"
    end
  end

  def message_source(message:, analyze:)
    if analyze
      /(source)/i.match(message)
    else
      "The main source for this bot can be found at:\n" +
      "https://github.com/NovelCOVID/API \n" +
      "They claim to get most of their information from: \n" +
      "https://www.worldometers.info/coronavirus/ \nand \n" +
      "https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_time_series"
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

  def message_region_data(message:)
    region = region_name_resolver(message: message)

    single_region_info(region)
  end

  def message_country_data(message:)
    country = country_name_resolver(message: message)

    single_country_info(country)
  end

  def message_unclear
    "I am sorry. I do not not understand. Please text help for a list of options"
  end

  def region_name_resolver(message:)
    region = Country::REGIONS.find { |r| message.upcase.include?(r)}&.gsub(" ", "_")
  end

  def country_name_resolver(message:)
    country = Country::COUNTRY_NAMES.find { | c | message.upcase.include?(c.upcase) }
  end

  def single_region_info(region)
    country_names = Country.const_get(region)
    countries = Country.where(name: country_names)
    covids = countries.map { |c| c.covid_dailies.most_recent }

    total_pop = sum_fields(countries, :population)
    total_cases = sum_fields(covids, :total_cases)
    total_deaths = sum_fields(covids, :total_deaths)

    spread = (total_cases / total_pop.to_f * 100).round(4)
    mortality_rate = (total_deaths / total_cases.to_f * 100).round(4)

    message =
    "Information for the #{country_names.length} countries in #{region.gsub("_", " ")}: \n" +
    "Total Cases: #{total_cases} - Total Deaths: #{total_deaths}. \n" +
    "Spread: #{spread}% of total population. \n" +
    "Mortality Rate: #{mortality_rate}%."
    message += "\n*East Asia does not include the PRofChina" if region == "EAST_ASIA"
    message
  end

  def single_country_info(country)
    nation = Country.find_by_name country
    daily = nation.covid_dailies.most_recent

    entry = CovidDaily.where(country_name: country )
                      .order(created_at: :desc)
                      .limit(1)
                      .first
    entry.country.update(line_request_count: entry.country.line_request_count + 1)
    "Information for #{country}: \n" +
    "Total Cases: #{entry.total_cases} - Total Deaths: #{entry.total_deaths} \n" +
    "Spread: #{nation.percent_infected}% of total population \n" +
    "7 Day Growth Rate: #{nation.growth_rate}% \n" +
    "Mortality Rate: #{entry.mortality_rate}%. \n" +
    "24h prior to data collection (#{entry.updated}): \n" +
    "New Cases #{entry.today_cases} - New Deaths #{entry.today_deaths}"
  end

  def sum_fields(items, field)
    items.sum {|i| i.try(field)}
  end
end

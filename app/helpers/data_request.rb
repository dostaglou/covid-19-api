module DataRequest
  include HTTParty
  class << self
    BASE_URL = "https://corona.lmao.ninja/countries"
    def request_data
      response = HTTParty.get(BASE_URL)
      parsed = JSON.parse response.body

      build_db_entry(parsed)
      msg_japan

      return nil
    end

    def build_db_entry(data)
      data.each do |datum|
        id = Country.find_or_create_by(name: datum["country"])&.id
        datum = {
          country_id: id,
          total_cases: datum["cases"] || 0,
          today_cases: datum["todayCases"] || 0,
          total_deaths: datum["deaths"] || 0,
          today_deaths: datum["todayDeaths"] || 0,
          recovered: datum["recovered"] || 0,
          active: datum["active"] || 0,
          critical: datum["critical"] || 0,
          case_per_million: datum["casesPerOneMillion"] || 0,
          death_per_million: datum["deathsPerOneMillion"] || 0,
          updated: Time.at(datum["updated"]).to_datetime,
        }

        CovidDaily.create(datum)
      end
    end

    def msg_japan
      japan = CovidDaily.where(country_id: "11c707f4-01c1-44cc-9752-3d118dea257e")
                        .order(created_at: :desc)
                        .limit(1)
                        .first

      SlackNotification.send_japan_data(data: japan.attributes.to_json)
    end
  end
end

module DataRequest
  include HTTParty
  class << self
    BASE_URL = "https://corona.lmao.ninja/v2/countries"
    def request_data
      byebug
      response = HTTParty.get(BASE_URL)
      parsed = JSON.parse response.body

      build_db_entry(parsed)
      msg_slack

      return nil
    end

    def build_db_entry(data)
      data.each do |datum|
        id = Country.find_or_create_by(name: datum["country"])&.id
        datum = {
          country_id: id,
          country_name: datum["country"],
          total_cases: datum["cases"] || 0,
          today_cases: datum["todayCases"] || 0,
          total_deaths: datum["deaths"] || 0,
          today_deaths: datum["todayDeaths"] || 0,
          recovered: datum["recovered"] || 0,
          active: datum["active"] || 0,
          critical: datum["critical"] || 0,
          case_per_million: datum["casesPerOneMillion"] || 0,
          death_per_million: datum["deathsPerOneMillion"] || 0,
          tests_conducted: datum["tests"],
          tests_per_million: datum["testsPerOneMillion"],
          updated: Time.at(datum["updated"]&.to_i / 1000).to_datetime,
        }

        CovidDaily.create(datum)
      end
    end

    def msg_slack
      rc = ["Japan", "USA", "France", "Canada", "China", "Philippines"]

      rc.map! do | country |
        CovidDaily.where(country_name: country )
                  .order(created_at: :desc)
                  .limit(1)
                  .first
      end

      final_msg =
        "Data Collected at: #{rc.first.updated}\n" +
        "--------------------------------- \n" +
        "Total Cases \n" +
        ":flag-jp: #{rc.first.total_cases} :flag-us: #{rc.second.total_cases} :flag-fr: #{rc.third.total_cases} :flag-ca: #{rc.fourth.total_cases} :flag-cn: #{rc.fifth.total_cases} :flag-ph: #{rc.last.total_cases} \n" +
        "Total Deaths: \n" +
        ":flag-jp: #{rc.first.total_deaths} :flag-us: #{rc.second.total_deaths} :flag-fr: #{rc.third.total_deaths} :flag-ca: #{rc.fourth.total_deaths} :flag-cn: #{rc.fifth.total_deaths} :flag-ph: #{rc.last.total_deaths} \n" +
        "--------------------------------- \n" +
        "Mortality Rates \n" +
        ":flag-jp: #{rc.first.mortality_rate}% :flag-us: #{rc.second.mortality_rate}% :flag-fr: #{rc.third.mortality_rate}% :flag-ca: #{rc.fourth.mortality_rate}% :flag-cn: #{rc.fifth.mortality_rate}% :flag-ph: #{rc.last.mortality_rate}% \n"

        SlackNotification.send_msg(data: final_msg)
    end
  end
end

class TwitterMessage

  def single_country_info(country)
    nation = Country.find_by_name(country)
    daily = nation.covid_dailies.most_recent

    "##{nation.name.gsub(" ", "_")}:\n" +
    "#{daily.total_cases} total cases\n" +
    "#{daily.total_deaths} deaths\n" +
    "#{daily.mortality_rate}% mortality rate."
  end

  def single_region_info(region)
    region.gsub!(" ", "_")
    country_names = Country.const_get(region)
    countries = Country.where(name: country_names)
    covids = countries.map { |c| c.covid_dailies.most_recent }

    total_pop = sum_fields(countries, :population)
    total_cases = sum_fields(covids, :total_cases)
    total_deaths = sum_fields(covids, :total_deaths)

    spread = (total_cases / total_pop.to_f * 100).round(4)
    mortality_rate = (total_deaths / total_cases.to_f * 100).round(4)

    "##{region}:\n" +
    "#{total_cases} total cases\n" +
    "#{total_deaths} deaths\n" +
    "#{spread}% spread\n" +
    "#{mortality_rate}% mortality rate"
  end

  def sum_fields(items, field)
    items.sum {|i| i.try(field)}
  end
end

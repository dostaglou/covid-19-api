class MainPageController < ApplicationController

  def page
    @countries = Country.all.order(name: :asc)
    @country = Country.find_by_name "Japan"
    @country_recent = @country.covid_dailies.most_recent
    @country_growth = @country.growth_rate
  end
end

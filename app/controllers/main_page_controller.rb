class MainPageController < ApplicationController

  def page
    @japan = Country.find_by_name "Japan"
    @japan_recent = @japan.covid_dailies.most_recent
    @japan_growth = @japan.growth_rate
  end
end

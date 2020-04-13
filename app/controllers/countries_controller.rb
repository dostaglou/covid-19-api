class CountriesController < ApplicationController
  before_action :create_baseline

  def create_baseline
    @regions = Country::REGIONS.sort
    @countries = Country.all.order(name: :asc)
  end

  def random
    @country_level = true
    @country = @countries.sample
    @country_recent = @country.covid_dailies.most_recent
    @country_growth = @country.growth_rate
    render :show
  end

  def show
    @country_level = true
    @country = @countries.find {|c| c.name == (params[:name]) }
    @country_recent = @country.covid_dailies.most_recent
    @country_growth = @country.growth_rate
  end

  def region
    @region = params[:name]
    @country_names = Country.const_get(@region)
    countries = Country.where(name: @country_names)
    covids = countries.map { |c| c.covid_dailies.most_recent }

    @total_pop = sum_fields(countries, :population)
    @total_cases = sum_fields(covids, :total_cases)
    @total_deaths = sum_fields(covids, :total_deaths)

    @spread = (@total_cases / @total_pop.to_f * 100).round(4)
    @mortality_rate = (@total_deaths / @total_cases.to_f * 100).round(4)

    render :show
  end

  private

  def sum_fields(items, field)
    items.sum {|i| i.try(field)}
  end
end

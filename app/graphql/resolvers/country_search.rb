class Resolvers::CountrySearch < Resolvers::Base
  argument :country_name, String, required: false, default_value: nil

  def resolve(country_name:)
    scope = Country.all
    scope = Country.where(name: country_name) if country_name

    scope
  end
end

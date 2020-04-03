class Types::CovidDailyType < Types::BaseObject

  # Columns
  field :total_cases, Integer, null: false
  field :total_deaths, Integer, null: false
  field :today_cases, Integer, null: false
  field :today_deaths, Integer, null: false
  field :recovered, Integer, null: false
  field :critical, Integer, null: false
  field :active, Integer, null: false
  field :case_per_million, Float, null: false
  field :death_per_million, Float, null: false
  field :country_name, String, null: false
  # Relations
  field :country, Types::CountryType, null: false
end

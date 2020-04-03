class Types::CountryType < Types::BaseObject

  # Columns
  field :name, String, null: false

  # Relations
  field :recent_update, Types::CovidDailyType, null: false
  field :all_updates, [Types::CovidDailyType], null: false


  def recent_update
    object.covid_dailies.order(updated: :desc).limit(1).first
  end

  def all_updates
    object.covid_dailies
  end
end

class AddCountryNameToCovidDaily < ActiveRecord::Migration[5.2]
  def change
    add_column :covid_dailies, :country_name, :string
  end
end

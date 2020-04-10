class AddPopulationToCountry < ActiveRecord::Migration[5.2]
  def change
    add_column :countries, :population, :integer
  end
end

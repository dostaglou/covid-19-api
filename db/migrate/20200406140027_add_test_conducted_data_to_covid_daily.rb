class AddTestConductedDataToCovidDaily < ActiveRecord::Migration[5.2]
  def change
    add_column :covid_dailies, :tests_conducted, :integer
    add_column :covid_dailies, :tests_per_million, :integer
  end
end

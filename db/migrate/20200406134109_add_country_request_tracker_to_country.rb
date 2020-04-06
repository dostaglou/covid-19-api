class AddCountryRequestTrackerToCountry < ActiveRecord::Migration[5.2]
  def change
    add_column :countries, :line_request_count, :integer, default: 0, null: false
  end
end

class CreateCovidDailies < ActiveRecord::Migration[5.2]
  def change
    create_table :covid_dailies, id: :uuid do |t|
      t.references :country, type: :uuid
      t.integer :total_cases, default: 0, null: false
      t.integer :today_cases, default: 0, null: false
      t.integer :total_deaths, default: 0, null: false
      t.integer :today_deaths, default: 0, null: false
      t.integer :recovered, default: 0, null: false
      t.integer :active, default: 0, null: false
      t.integer :critical, default: 0, null: false
      t.float :case_per_million, default: 0, null: false
      t.float :death_per_million, default: 0, null: false
      t.datetime :updated
      t.timestamps
    end
  end
end

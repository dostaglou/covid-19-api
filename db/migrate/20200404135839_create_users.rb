class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string :line_id
      t.string :line_name
      t.boolean :line_notifications
      t.string :line_countries
      t.datetime :line_deleted_at
      t.timestamps
    end
  end
end

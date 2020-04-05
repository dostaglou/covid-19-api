class AddLineTimeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :line_update_time, :string, default: "09:00", null: false
  end
end

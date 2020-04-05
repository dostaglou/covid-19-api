class AddSignedUpToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :line_signed_up, :boolean, default: false, null: false
  end
end

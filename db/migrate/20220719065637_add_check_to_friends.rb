class AddCheckToFriends < ActiveRecord::Migration[7.0]
  def change
    add_column :friends, :check, :boolean
  end
end

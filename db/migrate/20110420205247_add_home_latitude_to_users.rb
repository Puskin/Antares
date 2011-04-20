class AddHomeLatitudeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :home_latitude, :string
  end

  def self.down
    remove_column :users, :home_latitude
  end
end

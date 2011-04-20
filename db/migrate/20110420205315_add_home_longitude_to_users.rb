class AddHomeLongitudeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :home_longitude, :string
  end

  def self.down
    remove_column :users, :home_longitude
  end
end

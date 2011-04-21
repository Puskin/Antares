class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
    add_index :locations, :user_id
  end

  def self.down
    drop_table :locations
  end
end

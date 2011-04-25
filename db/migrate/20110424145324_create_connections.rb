class CreateConnections < ActiveRecord::Migration
  def self.up
    create_table :connections do |t|
      t.integer :user_id
      t.integer :contact_id
      t.integer :status
      t.timestamp :accepted_at

      t.timestamps
    end   
    add_index :connections, [:user_id, :contact_id]
  end

  def self.down
    drop_table :connections
  end
end

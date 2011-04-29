class CreateAppreciations < ActiveRecord::Migration
  def self.up
    create_table :appreciations do |t|
      t.integer :liker_id
      t.integer :liked_id
      t.timestamps
    end
    add_index :appreciations ,:liker_id
    add_index :appreciations ,:liked_id

  end

  def self.down
    drop_table :appreciations
  end
end

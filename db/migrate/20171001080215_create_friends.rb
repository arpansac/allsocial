class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.integer :friend_id, index: true, null: false
      t.boolean :confirmed, default: false

      t.timestamps null: false
    end
  end
end

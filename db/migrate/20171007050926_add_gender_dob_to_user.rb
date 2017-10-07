class AddGenderDobToUser < ActiveRecord::Migration
  def change
    add_column :users, :gender, :string
    add_column :users, :dob, :datetime
  end
end

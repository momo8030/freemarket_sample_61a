class ChangeDatatypePhoneNumberOfUsers < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :phone_number, :string, null: false, unique: true
  end

  def down
    change_column :users, :phone_number, :integer, null: false, unique: true
  end
end

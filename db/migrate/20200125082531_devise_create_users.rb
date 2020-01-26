# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :nickname, null: false
      t.string :email, null: false, unique: true
      t.string :password, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.integer :birthday, null: false
      t.string :comment
      t.integer :phone_number, null: false, unique: true

      t.string :encrypted_password, null: false, default: ""
      
      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
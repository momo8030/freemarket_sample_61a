class RemovePasswordFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :password, :string, null: false
  end
end

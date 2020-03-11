class RemoveDetailsFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :state, :integer
    remove_column :items, :category, :string
    remove_column :items, :size, :integer
    remove_column :items, :postage, :string
    remove_column :items, :region, :string
    remove_column :items, :shopping_date, :integer
    remove_column :items, :brand, :integer
  end
end

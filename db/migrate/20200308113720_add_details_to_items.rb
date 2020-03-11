class AddDetailsToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :condition_id, :integer, null: false
    add_column :items, :category_id, :integer, null: false
    add_column :items, :size_id, :integer
    add_column :items, :delivery_charge_id, :integer, null: false
    add_column :items, :prefecture_id, :integer, null: false
    add_column :items, :delivery_days_id, :integer, null: false
    add_column :items, :delivery_method_id, :integer, null: false
    add_column :items, :likes_count, :integer
    add_column :items, :brand, :text
  end
end

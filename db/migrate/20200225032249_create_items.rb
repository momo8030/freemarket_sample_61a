class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null:false
      t.integer :price, null:false
      t.string :comment
      t.integer :state, null:false
      t.string :category, null:false
      t.integer :size
      t.string :postage, null:false
      t.string :region, null:false
      t.integer :shopping_date, null:false
      t.integer :buyer_id, Class_name:"User", foreign_key:true
      t.integer :seller_id, Class_name:"User", null:false, foreign_key:true
      t.integer :brand, foreign_key:true
      t.timestamps
    end
  end
end

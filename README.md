## README
## freemarket_sample_61a DB設計

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false,unique: true|
|password|string|null:false|
|first_name|string|null: false|
|last_name|string|null: false|
|birthday|integer|null: false|
|comment|string||
|phone_number|integer|null: false,unique: true|

### アソシエーション
- has_one :addresses
- has_one :creditcards
- has_many :comments
- has_many :likes
- has_many :buyed_items, foreign_key: "buyer_id", class_name: "Item"
- has_many :saling_items, foreign_key: "seller_id", class_name: "Item"

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|name|string|null: false|
|price|integer|null: false|
|comment|string||
|state|string|null: false|
|category|string|null: false|
|size|integer||
|postage|string|null: false|
|region|string|null: false|
|shopping_date|integer|null: false|
|buyer_id|integer|Class_name:"User"|
|seller_id|integer|Class_name:"User"|
|brand_id|integer|foreign_kry: true|

### アソシエーション
- has_many :comments
- has_many :likes
- has_many :images
- has_many :category
- belongs_to :brands
- belongs_to :saller, class_name: "User"
- belongs_to :buyer, class_name: "User"

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null:false,unique: true|
|post_number|integer(7)|null: false|
|prefectrues|string|null: false|
|city|integer|null: false|

### アソシエーション
- has_one :user

## creditcardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null:false,unique: true|
|card_id|integer|null: false|
|customer_id|integer|null: false|

### アソシエーション
- has_one :user

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null:false,foreign_key: true|
|item_id|integer|null:false,foreign_key: true|
|text|text||

### アソシエーション
- belongs_to :user
- belongs_to :items

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null:false,foreign_key: true|
|item_id|integer|null:false,foreign_key: true|

### アソシエーション
- belongs_to :user
- belongs_to :items

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|url|text|null:false|
|item_id|integer|null:false,foreign_key: true|

### アソシエーション
- belongs_to :items

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
|accetry|string|null:false|

### アソシエーション
- belongs_to :items

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|text||
|item_id|integer|null:false,foreigin_key: true|

### アソシエーション
- has_many :items











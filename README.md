## README
## freemarket_sample_61a DB設計

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: flase|
|email|string|null: flase,unique: ture|
|password|string|null:flase|
|first_name|string|null: flase|
|last_name|string|null: flase|
|birthday|integer|null: flase|
|comment|string||
|phone_number|integer|null: flase,unique: ture|

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
|image|string|null: flase|
|name|string|null: flase|
|price|integer|null: flase|
|comment|string||
|state|string|null: flase|
|category|string|null: flase|
|size|integer||
|postage|string|null: flase|
|region|string|null: flase|
|shopping_date|integer|null: flase|
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
|user_id|integer|null:flase,unique: ture|
|post_number|integer(7)|null: flase|
|prefectures|string|null: flase|
|city|integer|null: flase|

### アソシエーション
- has_one :user

## creditcardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null:flase,unique: ture|
|card_id|integer|null: flase|
|customer_id|integer|null: flase|

### アソシエーション
- has_one :user

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null:flase,foreign_key: true|
|item_id|integer|null:flase,foreign_key: true|
|text|text||

### アソシエーション
- belongs_to :user
- belongs_to :items

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null:flase,foreign_key: true|
|item_id|integer|null:flase,foreign_key: true|

### アソシエーション
- belongs_to :user
- belongs_to :items

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|url|text|null:flase|
|item_id|integer|null:flase,foreign_key: true|

### アソシエーション
- belongs_to :items

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null:flase|
|accetry|string|null:flase|

### アソシエーション
- belongs_to :items

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|text||
|item_id|integer|null:flase,foreigin_key: ture|

### アソシエーション
- has_many :items











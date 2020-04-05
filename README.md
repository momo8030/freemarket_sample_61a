## README

# アプリケーション

#### チーム開発でコピーフリーマーケットサイトを作成しました

http://18.178.72.144

### basic認証のID
- 61wa

### パスワード
- 8888

# アプリケーション内で使用している技術
|種別|名称|
|------|----|
|開発言語	|Ruby(ver 2.5.1)|
|フレームワーク|Ruby on Rails(ver 5.2.4)|
|マークアップ|HTML(Haml),CSS(Sass)|
|フロントエンド|JavaScript(jQuery)|
|DB|MySQL2|
|本番環境|AWS|EC2|
|画像アップロード|carrierwave, AWS S3|
|ロボット判定機能|reCAPTCHA|
|自動デプロイ|capistrano|
|ユーザー管理|devise|
|クレジットカード管理|PayJP|
|パンくず表示機能|gretel|

# freemarket_sample_61a DB設計

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false,unique: true|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|birth_year|data|null: false|
|birth_month|data|null: false|
|birth_day|data|null: false|
|comment|string||
|phone_number|integer|null: false,unique: true|
|password|string|null:false|

### アソシエーション
- has_one :address
- has_one :creditcard
- has_many :comments
- has_many :likes
- has_many :todos
- has_many :bought_items, foreign_key: "buyer_id", class_name: "Item"
- has_many :selling_items, foreign_key: "seller_id", class_name: "Item"
- has_many :sns_credentials
- has_many :cards,dependent: :destroy

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|price|integer|null: false|
|comment|string|
|buyer_id|integer|Class_name:"User",foreign_key: true|
|seller_id|integer|Class_name:"User",null: false, foreign_key: true|
|condition_id|integer|null: false|
|category_id|integer|null: false|
|size_id|integer|
|delivery_charge_id|integer|null: false|
|prefecture_id|integer|null: false|
|delivery_days_id|integer|null: false|
|delivery_method_id|integer|null: false|
|likes_count|integer|
|brand|text|

### アソシエーション
- has_many   :images,dependent: :destroy
- has_many :likes, dependent: :destroy

- belongs_to :category
- belongs_to :seller, class_name: "User"

- belongs_to_active_hash :category
- belongs_to_active_hash :condition
- belongs_to_active_hash :size
- belongs_to_active_hash :delivery_charge
- belongs_to_active_hash :delivery_days
- belongs_to_active_hash :delivery_method

`active_hash`

[category](https://github.com/momo8030/freemarket_sample_61a/blob/master/app/models/category.rb)

[condition](https://github.com/momo8030/freemarket_sample_61a/blob/master/app/models/condition.rb)

[size](https://github.com/momo8030/freemarket_sample_61a/blob/master/app/models/size.rb)

[delivery_charge](https://github.com/momo8030/freemarket_sample_61a/blob/master/app/models/delivery_charge.rb)

[delivery_days](https://github.com/momo8030/freemarket_sample_61a/blob/master/app/models/delivery_days.rb)

[delivery_method](https://github.com/momo8030/freemarket_sample_61a/blob/master/app/models/delivery_method.rb)



## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|prefecture_id|string|null: false|
|city|string|null: false|

### アソシエーション
-  belongs_to_active_hash :prefecture

`active_hash`

[prefecture](https://github.com/momo8030/freemarket_sample_61a/blob/master/app/models/prefecture.rb)

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null:false,unique: true|
|customer_id|integer|null: false|
|card_id|integer|null: false|
|created_at|integer|null: false|
|updated_at|integer|null: false|

### アソシエーション
- belongs_to :user

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null:false,foreign_key: true|
|item_id|references|null:false,foreign_key: true|

### アソシエーション
- belongs_to :user
- belongs_to :item, counter_cache: :likes_count

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|url|text|null:false|
|item_id|references|null:false,foreign_key: true|

### アソシエーション
- belongs_to :item

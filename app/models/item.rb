class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :size
  belongs_to_active_hash :delivery_charge
  belongs_to_active_hash :delivery_days
  belongs_to_active_hash :delivery_method
  # belongs_to user, foreign_key: 'user_id'
  belongs_to :category
  belongs_to :seller, class_name: "User"
  # belongs_to :buyer, class_name: "User"
  has_many   :images,dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :name, presence: true
  validates :images, presence: true
  validates :price, presence: true
  validates :comment, presence: true
  validates :condition_id, presence: true
  validates :category_id, presence: true
  validates :size_id, presence: true
  validates :delivery_charge_id, presence: true
  validates :prefecture_id, presence: true
  validates :delivery_days_id, presence: true
  validates :delivery_method_id, presence: true
  # validates :brand, :numericality => { :allow_blank => true }

  # validates :buyer_id, :numericality => { :allow_blank => true }
  validates :seller_id, :numericality => { :allow_blank => true }
  validates :likes_count, :numericality => { :allow_blank => true }

  

  accepts_nested_attributes_for :images, allow_destroy: true

end

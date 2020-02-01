class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :address
  has_one :creditcard
  has_many :comments
  has_many :likes
  has_many :todos
  has_many :bought_items, foreign_key: "buyer_id", class_name: "Item"
  has_many :selling_items, foreign_key: "seller_id", class_name: "Item"

  validates :email, presence: true
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  has_one :address
  has_one :creditcard
  has_many :comments
  has_many :likes
  has_many :todos
  has_many :bought_items, foreign_key: "buyer_id", class_name: "Item"
  has_many :selling_items, foreign_key: "seller_id", class_name: "Item"
  has_many :sns_credentials
  has_many :cards,dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,             presence: true, uniqueness: true
  validates :nickname,          presence: true
  validates :password,          presence: true, length: { minimum:7 }
  validates :first_name,        presence: true
  validates :last_name,         presence: true
  validates :first_name_kana,   presence: true,format: {with: /\A[ァ-ヶー－]+\z/}
  validates :last_name_kana,    presence: true,format: {with: /\A[ァ-ヶー－]+\z/}
  validates :birth_year,        presence: true, numericality: true
  validates :birth_month,       presence: true, numericality: true
  validates :birth_day,         presence: true, numericality: true
  validates :phone_number,      presence: true, uniqueness: true, numericality: true

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    # userが登録済みの場合はそのままログインの処理へ行くので、ここでsnsのuser_idを更新しておく
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
end
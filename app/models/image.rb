class Image < ApplicationRecord
  belongs_to :item
  # 画像アップロード時に必要な記述
  mount_uploader :url, ImageUploader 

  validates :url, presence: true
end

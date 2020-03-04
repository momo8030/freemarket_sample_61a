class Image < ApplicationRecord
    # 画像アップロード時に必要な記述
  mount_uploaders :url,ImageUploader
  belongs_to :item 

  validates :url,:item_id, presence: true
end

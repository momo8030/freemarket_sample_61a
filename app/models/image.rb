class Image < ApplicationRecord
  belongs_to :item
  # 画像アップロード時に必要な記述
  # mount_uploders :url,ImageUploder 

  validates :url,:item_id, presence: true
end

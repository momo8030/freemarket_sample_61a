class Image < ApplicationRecord
  belongs_to :item
  # mount_uploders :url,ImageUploder

  validates :url, presence: true
  validates :item_id, presence: true
end

class Board < ApplicationRecord
  mount_uploader :board_image, BoardImageUpload
  belongs_to :user
  has_many :bookmarks, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65535 }
end

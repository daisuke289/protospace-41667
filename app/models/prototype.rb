class Prototype < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  # バリデーション
  validates :title, presence: true
  validates :catch_copy, presence: true
  validates :concept, presence: true
  validates :image, presence: true

  # アソシエーション
  has_many :comments, dependent: :destroy # コメントとの関連を追加
end
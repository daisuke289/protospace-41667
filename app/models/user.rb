class User < ApplicationRecord
  # Deviseの設定
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # バリデーションの追加
  validates :name, presence: true
  validates :profile, presence: true
  validates :occupation, presence: true
  validates :position, presence: true

  # アソシエーションの追加
  has_many :prototypes, dependent: :destroy
  has_many :comments, dependent: :destroy # コメントとの関連を追加
end
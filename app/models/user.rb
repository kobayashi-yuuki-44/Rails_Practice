class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :last_name, presence: true, length: { maximum: 255 }
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
end

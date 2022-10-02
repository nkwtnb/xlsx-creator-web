class User < ApplicationRecord
  has_secure_password
  has_many :forms
  validates :name, presence: true
  validates :user_id, presence: true

end
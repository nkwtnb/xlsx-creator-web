class User < ApplicationRecord
  has_secure_password
  has_many :forms
  validates :email, presence: true

end
class Contactu < ActiveRecord::Base

validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
    format:     { with: VALID_EMAIL_REGEX }
 validates :phone, presence: true, length: { maximum: 10 }
 validates :comment, presence: true, length: { maximum: 500 }
end

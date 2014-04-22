class Story < ActiveRecord::Base
  searchkick
  
  belongs_to :user
  validates :title, presence: true
  validates :news, presence: true
  validates :user_id, presence: true
end

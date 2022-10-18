class Book < ApplicationRecord
  
  has_one_attached :profile_image
  
  validates :title, presence: true
  validates :body, presence: true
  
end

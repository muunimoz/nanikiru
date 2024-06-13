class Area < ApplicationRecord
  has_many :posts, dependent: :destroy
  
  validates :area_name, presence: true
end

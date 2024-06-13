class Temperature < ApplicationRecord
  has_many :posts, dependent: :destroy
  
  validates :temperature_name, presence: true
end

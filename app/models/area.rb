class Area < ApplicationRecord
  has_many :posts, dependent: :destroy
end

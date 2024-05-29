class Temperature < ApplicationRecord
  belongs_to :post, optional: true
end

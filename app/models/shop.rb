class Shop < ApplicationRecord
  belongs_to :company
  has_many :works
end

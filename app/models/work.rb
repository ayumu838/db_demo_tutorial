class Work < ApplicationRecord
  belongs_to :shop
  has_many :entries
end

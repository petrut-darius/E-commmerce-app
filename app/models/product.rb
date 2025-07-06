class Product < ApplicationRecord
  has_many :orderables
  has_many :carts, through: :orderables
  has_many :comments
  acts_as_favoritable
  enum :sex, { male: 0, female: 1 }
  validates :sku, presence: true, uniqueness: true
end

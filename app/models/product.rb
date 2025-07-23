class Product < ApplicationRecord
  has_many :orderables
  has_many :carts, through: :orderables
  has_many :comments
  acts_as_favoritable
  enum :sex, { male: 0, female: 1 }
  validates :sku, presence: true, uniqueness: true
  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :tags
  has_many_attached :images
end

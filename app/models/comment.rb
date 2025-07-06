class Comment < ApplicationRecord
  belongs_to :product, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true
end

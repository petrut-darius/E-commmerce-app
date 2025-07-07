class UserInteraction < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :event_type, presence: true
end

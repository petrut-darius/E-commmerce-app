class Orderable < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def total
    (quantity || 0) * (product&.price || 0)
  end

  def to_builder
    Jbuilder.new do |orderable|
      orderable.price product.stripe_price_id
      orderable.quantity quantity
    end
  end
end

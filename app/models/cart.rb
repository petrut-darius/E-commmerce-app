class Cart < ApplicationRecord
  has_many :orderables
  has_many :products, through: :orderables

  def total
    orderables.includes(:product).sum do |orderable|
      (orderable.quantity || 0) * (orderable.product&.price || 0)
    end
  end

  def success
  end

  def cancel
  end
end

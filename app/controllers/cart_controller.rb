class CartController < ApplicationController
  def show
    @cart = current_cart
    @render_cart = false
  end

    def add
      @product = Product.find_by(id: params[:id])
      quantity = params[:quantity].to_i
      current_orderbale = @cart.orderables.find_by(product_id: @product.id)

      if current_orderbale && quantity > 0
        current_orderbale.update(quantity: current_orderbale.quantity + quantity)
      elsif current_orderbale && quantity <= 0
        current_orderbale.destroy
      else
        @cart.orderables.create(product: @product, quantity: quantity)
      end
    end


  def remove
  orderable = Orderable.find_by(id: params[:id])
  if orderable
    orderable.destroy
    redirect_to cart_path, notice: "Item removed from cart."
  else
    redirect_to cart_path, alert: "Item not found."
  end
  end
end

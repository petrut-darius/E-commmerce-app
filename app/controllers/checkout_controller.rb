class CheckoutController < ApplicationController
  def create
    # @cart is already initialized by ApplicationController
    line_items = @cart.orderables.map do |item|
      if item.product.stripe_price_id.present?
        {
          price: item.product.stripe_price_id,
          quantity: item.quantity
        }
      else
        {
          price_data: {
            currency: "usd",
            unit_amount: (item.product.price * 100).to_i,
            product_data: {
              name: item.product.name
            }
          },
          quantity: item.quantity
        }
      end
    end

    @session = Stripe::Checkout::Session.create(
      customer: current_user.stripe_customer_id,
      payment_method_types: [ "card" ],
      line_items: line_items,
      mode: "payment",
      success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: checkout_cancel_url
    )

    redirect_to @session.url, allow_other_host: true
  end
end

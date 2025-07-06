class FavoritesController < ApplicationController
  before_action :authenticate_user!
  def index
    @favorites = current_user.favorites_by_type("Product")
    @products = Product.where(id: @favorites.map(&:favoritable_id))
  end
end

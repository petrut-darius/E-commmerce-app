class WelcomeController < ApplicationController
  def index
    @visits = Ahoy::Visit.includes(:events).all
  end
end

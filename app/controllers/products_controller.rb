class ProductsController < ApplicationController
  include Trackable
  helper Commontator::ApplicationHelper
  before_action :authenticate_user!
  before_action :set_product, only: %i[ show edit update destroy add_to_favorite delete_from_favorite ]
  before_action :set_recommender, only: %i[ show ]

  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/1 or /products/1.json
  def show
    @comment = Comment.new
    @comments = @product.comments
    track "Viewed Product", title: @product.name

    if current_user
      recommended_ids = @recommender.recommend(current_user.id, count: 5)
      @recommended_products = Product.find(recommended_ids)
    else
      @recommended_products = Product.order("RANDOM()").limit(5)
    end
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    authorize @product
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_path, status: :see_other, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add_to_favorite
    current_user.favorite(@product)
    flash[:notice] = "Added to favorites!"
    redirect_to @product
  end

  def delete_from_favorite
    current_user.unfavorite(@product)
    flash[:notice] = "Delete from favorites!"
    redirect_to @product
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:sku, :sex, :name, :size, :color)
  end

  def set_recommender
    if File.exist?("tmp/disco_model.bin")
      @recommender = Marshal.load(File.read("tmp/disco_model.bin"))
    else
      @recommender = Disco::Recommender.new
    end
  end
end

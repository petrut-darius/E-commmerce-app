ActiveAdmin.register Product do
  controller do
    def scoped_collection
      Product.page(params[:page])
    end
  end
end

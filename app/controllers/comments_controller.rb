class CommentsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.build(comment_params)

    if @comment.save
      flash[:notice] = "Comment added"
      redirect_to @product
    else
      flash[:alert] = "Failed to add comment"
      redirect_to @product
    end
  end

  def comment_params
    params.require(:comment).permit(:title, :body)
  end
end

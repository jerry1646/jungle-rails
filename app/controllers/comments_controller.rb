class CommentsController < ApplicationController

  before_action :need_login

  def create
    @product = Product.find(params[:product_id])

    @comment = Comment.new(comment_params)

    @comment.product = @product
    @comment.user = current_user

    if @comment.save
      redirect_to products_path
    else
      redirect_to product_path(:id => params[:product_id])
    end
  end

  def destroy
    @comment = Comment.find params[:id]
    @comment.destroy
    redirect_to product_path(:id => params[:product_id])
  end

  private

  def comment_params
    params.require(:comment).permit(
      :description,
      :rating
    )
  end
end

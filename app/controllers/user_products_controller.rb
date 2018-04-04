class UserProductsController < ApplicationController

  def create
    @product = Product.find(params[:product_id])
    @user_product = @product.user_products.new(user_product_params)
    if current_user.points > @product.product_points
      @user_product.save
      redirect_to products_path
      flash[:notice] = "商品成功兌換，請預約維修站取貨!"
    else
      redirect_to products_path
      flash[:alert] = "您尚未有足夠點數，加把勁賺取積分吧!"
    end
  end


  private

  def user_product_params
    params.permit(:user_id, :product_id)
  end

 
end

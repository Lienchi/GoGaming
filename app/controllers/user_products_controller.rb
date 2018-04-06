class UserProductsController < ApplicationController

  def create
    @product = Product.find(params[:product_id])
    @user_product = @product.user_products.new(user_product_params)
    
      @user_product.save
      UserMailer.notify_order_create(@user_product).deliver_now!
      redirect_to products_path
      flash[:notice] = "商品成功兌換，請預約維修站取貨!"
  
  end


  private

  def user_product_params
    params.permit(:user_id, :product_id)
  end

 
end

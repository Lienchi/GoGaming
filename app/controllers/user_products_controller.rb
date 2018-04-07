class UserProductsController < ApplicationController

  def create
    @product = Product.find(params[:product_id])
    @repairstore = Repairstore.find(params[:user_product][:repairstore_id])
    @user_product = @product.user_products.where(user_id: current_user).new(user_product_params)

      @user_product.save!
      current_user.subtract_points(@product.product_points)
      redirect_to products_path
      flash[:notice] = "商品成功兌換，請於" + " #{@repairstore.name} " + "取貨!"
  
  end


  private

  def user_product_params
    params.require(:user_product).permit(:user_id, :product_id, :repairstore_id)
  end

 
end

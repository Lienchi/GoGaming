class UserProductsController < ApplicationController


  def create
    @product = Product.find(params[:product_id])
    @repairstore = Repairstore.find_by_id(params[:user_product][:repairstore_id])
    @user_product = @product.user_products.where(user_id: current_user).new(user_product_params)
   
    if @repairstore.blank?
      redirect_to products_path
      flash[:notice]="請選擇取貨店家"
    elsif current_user.points > @product.product_points
      @user_product.save!
      current_user.subtract_points(@product.product_points)
      UserMailer.notify_order_create(@user_product).deliver_now!
      redirect_to products_path
      flash[:notice] = "商品成功兌換，請於" + " #{@repairstore.name} " + "取貨!"
    else
      redirect_to products_path
      flash[:notice] = "您的點數不足，請加把勁挑戰任務!"
    end
  end


  private

  def user_product_params
    params.require(:user_product).permit(:user_id, :product_id, :repairstore_id)
  end

 
end

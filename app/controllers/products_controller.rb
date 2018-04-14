class ProductsController < ApplicationController

  def index

    @products = Product.order(:product_points)
    @user_product = UserProduct.new

  end
end

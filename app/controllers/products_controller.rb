class ProductsController < ApplicationController

  def index

    @products = Product.all
    @user_product = UserProduct.new
  end
end

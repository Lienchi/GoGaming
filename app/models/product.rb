class Product < ApplicationRecord
  has_many :user_products
  has_many :users, through: :user_products, source: :user
end

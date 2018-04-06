class UserMailer < ApplicationMailer

  default from: "Gogoro <gogoroproject@gmail.com>"

  def notify_order_create(user_product)
    @user_product = user_product
    @content = "您的商品已兌換成功!請於#{Time.now+10.days}到指定門市取貨"

    mail to: user_product.user.email,
    subject: "Gogoro | 兌換成功: 編號#{@user_product.id}"
  end
end

class UserMailer < ApplicationMailer

  default from: "Gogoro <gogoroproject@gmail.com>"

  def notify_order_create(user_product)
    @user_product = user_product
    @content = "您的 '#{@user_product.product.name}' 已兌換成功!請於#{Time.now+10.days}後於維修時間: '#{@user_product.repairstore.repairhours}' ，到 '#{@user_product.repairstore.name}' 取貨! "
   
    mail to: user_product.user.email,
    subject: "Gogoro | 兌換成功: 取貨編號#{@user_product.id}"
  end
end

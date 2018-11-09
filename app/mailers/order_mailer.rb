class OrderMailer < ApplicationMailer
  def order_email(email_vars)
    @user, @order, @line_items, @items, @item_quantities = email_vars
    mail(to: 'jerrysong131@gmail.com',
      subject: "[Jungle]Order Confirmation: Order# #{@order.id}")
  end
end

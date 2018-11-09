# This is not working


class OrderMailerPreview < ActionMailer::Preview

  def order_email
    get_detailed_order(3)

    @current_user = User.find(1)

    OrderMailer.order_email([@current_user, @order, @line_items, @items, @item_quantities])

  end

  private

  def get_items_from_order(line_items, item_quantities)
    item_ids = line_items.map do |line_item|
      item_quantities.push(line_item.quantity)
      line_item.product_id
    end
    items = Product.all.find(item_ids)
  end

  def get_total_price(items, item_quantities)
    total_price = 0.0
    items.each_index do |i|
      total_price += items[i].price_cents * item_quantities[i]
    end
    return total_price
  end

  def get_detailed_order(order_id)
    @item_quantities = []

    @order = Order.find(order_id)
    @line_items = @order.line_items
    @items = get_items_from_order(@line_items, @item_quantities)
    @total_price = get_total_price(@items, @item_quantities)
  end

end
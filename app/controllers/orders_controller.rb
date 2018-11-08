class OrdersController < ApplicationController

  def show
    @item_quantities = []

    @order = Order.find(params[:id])
    @line_items = @order.line_items

    @items = get_items_from_order(@line_items, @item_quantities)
    @total_price = get_total_price(@items, @item_quantities)

  end

  def create
    charge = perform_stripe_charge
    order  = create_order(charge)

    if order.valid?
      empty_cart!
      redirect_to order, notice: 'Your Order has been placed.'
    else
      redirect_to cart_path, flash: { error: order.errors.full_messages.first }
    end

  rescue Stripe::CardError => e
    redirect_to cart_path, flash: { error: e.message }
  end

  private

  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end

  def perform_stripe_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      cart_subtotal_cents,
      description: "Khurram Virani's Jungle Order",
      currency:    'cad'
    )
  end

  def create_order(stripe_charge)
    order = Order.new(
      email: params[:stripeEmail],
      total_cents: cart_subtotal_cents,
      stripe_charge_id: stripe_charge.id, # returned by stripe
    )

    enhanced_cart.each do |entry|
      product = entry[:product]
      quantity = entry[:quantity]
      order.line_items.new(
        product: product,
        quantity: quantity,
        item_price: product.price,
        total_price: product.price * quantity
      )
    end
    order.save!
    order
  end

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
end

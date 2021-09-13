class Public::OrdersController < ApplicationController
  def new
    if !current_customer.cart_items.exists?
     redirect_to cart_items_path
    end
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @order.payment_method = params[:order][:payment_method]



    if params[:order][:address_option] == "0"
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.last_name + current_customer.first_name

    elsif params[:order][:address_option] == "1"
    @order_address = Shipping.find(params[:order][:shipping_id])
    @order.postal_code = @order_address.postal_code
    @order.address = @order_address.address
    @order.name = @order_address.name

    elsif params[:order][:address_option] == "2"
    @order.postal_code = params[:order][:postal_code]
    @order.address = params[:order][:order_address]
    @order.name = params[:order][:address_name]
    end
    # render :new if @order.invalid?
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.order_status = "入金待ち"
    @order.save
    @cart_items = current_customer.cart_items.all
      @cart_items.each do |cart_item|
        @order_details = @order.order_details.new
        @order_details.item_id = cart_item.item.id
        @order_details.price = cart_item.item.price
        @order_details.amount = cart_item.amount
        @order_details.making_status = "製作不可"
        @order_details.save
        current_customer.cart_items.destroy_all
      end
    redirect_to complete_path
    # render :new and return if params[:back] || !@order.save
    # redirect_to @order
  end

  def index
    @orders = current_customer.orders.page(params[:page]).per(10).reverse_order
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_details

    @subtotal = @order.total_payment - @order.shipping_cost
    # @order.payment

  end

  def complete
  end

  private
  def order_params
    params.require(:order).permit(:address, :payment_method, :postal_code, :name, :total_payment, :shipping_cost)
  end

end
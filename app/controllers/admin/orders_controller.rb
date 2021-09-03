class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
     @order = Order.find(params[:id])
     @customer = @order.customer
     @items = Item.all
  end

  def update
     @order = Order.find(params[:id])
    if defined? order_params[:order_status]
     @customer = @order.customer
     @items = Item.all
     @order_details = @order.order_details

     if @order.update(order_params)
      redirect_to admin_order_path(@order)
     else
      render :show
     end
    end
  end

  private
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_cost, :payment_method, :order_status, :total_payment, :created_at)
  end
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :email, :last_name_kana, :first_name_kana, :postal_code, :address, :phone_number, :is_deleted)
  end
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :genre_id, :image, :is_active, :created_at, :updated_at)
  end
  def order_detail_params
     params.require(:order_detail).permit(:making_status)
  end
end


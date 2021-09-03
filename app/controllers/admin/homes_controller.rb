class Admin::HomesController < ApplicationController
  def top
     @orders = Order.all.page(params[:page]).per(10)
     if params[:id]
       @customer = Customer.find(params[:id])
       @order = @customer.orders
       ## customer
     else
       @order = Order.all
     end
  end
end

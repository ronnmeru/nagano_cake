class Admin::OrderDetailsController < ApplicationController
 before_action :authenticate_admin!


 def update
     @order_detail = OrderDetail.find(params[:order_detail][:order_detail_id])
     @order_detail.update(order_detail_params)
     if @order_detail.making_status== 2
        @order_detail.order.update(order_status: :入金待ち)
     end
     if @order_detail.making_status== 3
        @order_detail.order.update(order_status: :入金確認)
     end
    if @order_detail.update(making_status: order_detail_params[:making_status])
       redirect_to admin_order_path(params[:id])
    else
       render :'order/show'
    end
 end


  private
    def order_detail_params
     params.require(:order_detail).permit(:making_status)
    end
end

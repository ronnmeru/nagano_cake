class Admin::OrderDetailsController < ApplicationController
 before_action :authenticate_admin!


 def update
     @order_detail = OrderDetail.find(params[:order_detail][:order_detail_id])
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

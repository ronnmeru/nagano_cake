class Public::OrderDetailsController < ApplicationController
 before_action :authenticate_admin!




  def update
     @order_detail = OrderDetail.find(params[:order_detail][:order_detail_id])

    if @order_detail.update(production_status: order_detail_params[:production_status])
    p @order_detail

     redirect_to admins_order_path(params[:id])
    else
     render :'order/show'
    end
  end


  private
    def order_detail_params
     params.require(:order_detail).permit(:production_status)
    end
end


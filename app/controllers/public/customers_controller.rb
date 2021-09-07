class Public::CustomersController < ApplicationController
  def show
  end

  def edit
  end

  def update
      if current_customer.update(customer_params)
      redirect_to customer_params
      else
        render :edit
      end
  end

 def  withdraw
     current_customer.update(is_deleted: true)
     reset_session
     redirect_to root_path
 end

  def usubscribe
  end


private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :phone_number, :email, :is_deleted)
  end

end
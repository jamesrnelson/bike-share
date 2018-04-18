class OrdersController < ApplicationController
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::NumberHelper

  def show
    @order = Order.find(params[:id])
  end

  def create
    if @basket.checkout(order_params)
      session[:cart] = @basket.contents
      flash[:success] = "Successfully submitted your order totaling #{number_to_currency(@basket.total_cost)}"
      redirect_to dashboard_path
      @basket.clear
    else
      flash[:error] = "Full Name and Address are required fields"
      redirect_to cart_path
    end
  end

  def update
    order = Order.find(params[:id])
    order.update_attribute(:status, 3) if params[:status] == 'cancelled'
    order.update_attribute(:status, 2) if params[:status] == 'paid'
    order.update_attribute(:status, 1) if params[:status] == 'completed'
    flash[:notice] = "Order \##{order.id} was updated!"
    redirect_to admin_dashboard_path
  end

  private
    def order_params
      params.require(:order).permit(:fullname, :address)
    end
end

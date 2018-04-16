class OrdersController < ApplicationController
  include ActionView::Helpers::TextHelper

  def show
    @order = Order.find(params[:id])
  end

  def create
    flash[:success] = "Successfully submitted your order totaling $#{'%.2f' % @basket.total_cost}"
    @basket.checkout(order_params)
    @basket.clear
    session[:cart] = @basket.contents
    redirect_to dashboard_path
  end

  def update
    order = Order.find(params[:id])
    order.update_attribute(:status, 3) if params[:status] == 'cancelled'
    order.update_attribute(:status, 2) if params[:status] == 'paid'

    flash[:notice] = "Order \##{order.id} was updated!"
    redirect_to admin_dashboard_path
  end

  private
    def order_params
      params.require(:order).permit(:fullname, :address)
    end
end

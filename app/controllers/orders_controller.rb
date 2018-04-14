class OrdersController < ApplicationController
  include ActionView::Helpers::TextHelper

  def show
    @order = Order.find(params[:id])
  end

  def create
    flash[:notice] = "Successfully submitted your order totaling $#{'%.2f' % @basket.total_cost}"
    @basket.checkout(order_params)
    @basket.clear
    session[:cart] = @basket.contents
    redirect_to dashboard_path
  end

  private
    def order_params
      params.require(:order).permit(:fullname, :address)
    end
end

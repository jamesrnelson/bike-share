class OrdersController < ApplicationController
  include ActionView::Helpers::TextHelper

  def show

  end

  def create
    flash[:notice] = "Successfully submitted your order totaling $#{'%.2f' % @basket.total_cost}"
    @basket.checkout
    @basket.clear
    session[:cart] = @basket.contents
    redirect_to dashboard_path
  end
end

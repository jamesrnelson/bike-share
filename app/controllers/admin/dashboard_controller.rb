class Admin::DashboardController < Admin::BaseController
  def index
    @orders = Order.where(nil)
    @orders = @orders.status(params[:status]) if params[:status].present?
    @ordered_orders = Order.count_by_status(0)
    @completed_orders = Order.count_by_status(1)
    @paid_orders = Order.count_by_status(2)
    @cancelled_orders = Order.count_by_status(3)
  end
end

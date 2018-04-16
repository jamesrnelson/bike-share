class Admin::ItemsController < Admin::BaseController
  def new
    @item = Item.new
  end

  def create
    item = Item.new(item_params)
    if item.save
      flash[:success] = "#{item.title} has been added to the Bike Shop"
      redirect_to admin_bike_shop_path
    else
      flash[:error] = 'Title, description and price are required fields.'
      redirect_to admin_bike_shop_new_path
    end
  end

  private
    def item_params
      params.require(:item).permit(:title, :description, :price, :image)
    end
end

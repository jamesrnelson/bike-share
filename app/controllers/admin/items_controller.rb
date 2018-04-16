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

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if params[:status]
      @item.update_attribute(:status, 0) if params[:status] == 'retired'
      @item.update_attribute(:status, 1) if params[:status] == 'active'
      redirect_to admin_bike_shop_path
    end
    if @item.update(item_params)
      flash[:success] = "You have updated #{@item.title}"
      redirect_to admin_bike_shop_path
    else
      flash[:error] = "You were unable to update #{@item.title}"
      render :edit
    end
  end

  private
    def item_params
      params.require(:item).permit(:title, :description, :price, :image)
    end
end

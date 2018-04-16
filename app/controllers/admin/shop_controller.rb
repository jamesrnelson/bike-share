class Admin::ShopController < Admin::BaseController
  def index
    @items = Item.all
  end
end

class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def show
    @cart = Cart.find_by(user_id: current_user.id)
  end

  def create
    item = Item.find(params[:item_id])

    @basket.add_item(item.id)
    session[:cart] = @basket.contents

    flash[:notice] = "You now have #{pluralize(@basket.count_of(item.id), item.title)}."
    redirect_to bike_shop_path
  end

  def update
    @basket.update_item(params[:cart][:item], params[:cart][:quantity])
    flash[:notice] = "Cart Updated!"
    redirect_to cart_path
  end

  def destroy
    @basket.remove(params[:item])
    item = Item.find(params[:item].to_i)
    flash[:notice] = %Q[Successfully removed <a href="#{item_path(item)}">#{item.title}</a> from your cart.]
    redirect_to cart_path
  end
end

class CartsController < ApplicationController
  def show
    @cart = Cart.where(user_id: session[:user_id]) if current_user
  end

  def create
    if current_user
      cart = current_user.cart.find_by(item_id: params[:item_id])
      if cart
        params[:quantity] += cart.quantity
        cart.update(cart_params)
      else
        current_user.cart.new(cart_params)
      end
      if item.save
        flash[:success] = "Item added to cart!"
        redirect_to root_path
      else
        flash[:error] = "Unable to add item!"
        redirect_to root_path
      end
    else
      if session[:cart].has_key(params[:item_id].to_s)
        session[:cart][params[:item_id].to_s] += 1
      else
        session[:cart][params[:item_id].to_s] = 1
      end
      redirect_to root_path
    end
  end

  private

  def cart_params
    params.permit(:item_id, :quantity)
  end

  def item_count_increase(quantity)
    params[:quantity] += quantity
  end
end

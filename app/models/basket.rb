class Basket
  attr_reader :contents

  def initialize(initial_contents, user=nil)
    @contents = initial_contents || Hash.new(0)
    @current_user = user
  end

  def find_item(id_string)
    Item.find(id_string.to_i)
  end

  def total_count
    @contents.values.sum
  end

  def total_cost
    @contents.sum do |item, quantity|
      quantity * find_item(item).price
    end
  end

  def count_of(id)
    @contents[id.to_s]
  end

  def add_item(id)
    @contents[id.to_s] ||= 0
    @contents[id.to_s] += 1
    if @current_user
      cart_item = @current_user.carts.find_by(item_id: id)
      cart_item ||= @current_user.carts.new(item_id: id, quantity: 0)
      params = { quantity: @contents[id.to_s] }
      cart_item.update(params)
      cart_item.save
    end
  end

  def update_item(id, quantity)
    @contents[id] = quantity.to_i
    if @contents[id] < 1
      @contents.delete(id)
    end
    if @current_user
      cart_item = @current_user.carts.find_by(item_id: id.to_i)
      cart_item ||= @current_user.carts.new(item_id: id, quantity: 0)
      if quantity.to_i < 1
        cart_item.destroy
      else
        params = {quantity: quantity}
        cart_item.update(params)
        cart_item.save
      end
    end
  end

  def remove(id)
    @contents.delete(id)
    if @current_user
      @current_user.carts.find_by(item_id: id.to_i).destroy
    end
  end

  def checkout(order_params)
    transaction = @current_user.orders.maximum(:id)
    if transaction
      transaction += 1
    else
      transaction = 1
    end
    order = @current_user.orders.new(fullname: order_params[:fullname], address: order_params[:address])
    if order.save
      @contents.each do |item, quantity|
        order.order_items.create(item_id: item, quantity: quantity)
      end
    else
      false
    end
  end

  def clear
    @contents = Hash.new(0)
    if @current_user
      @current_user.carts.each do |cart|
        cart.destroy
      end
    end
  end
end

class Basket
  attr_reader :contents

  def initialize(initial_contents, user=nil)
    @contents = initial_contents || Hash.new(0)
    @current_user = user
  end

  def total_count
    @contents.values.sum
  end

  def count_of(id)
    @contents[id.to_s]
  end

  def add_item(id)
    @contents[id.to_s] += 1
    if @current_user
      cart_item = @current_user.cart.find_by(item_id: id)
      cart_item ||= @current_user.cart.new(item_id: id, quantity: 0)
      params = {quantity: @contents[id.to_s]}
      params.permit(:quantity)
      cart_item.update(params)
      cart_item.save
    end
  end
end

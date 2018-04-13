class RemoveQuantityFromOrderItems < ActiveRecord::Migration[5.1]
  def change
    remove_column :order_items, :quantity, :integer
  end
end

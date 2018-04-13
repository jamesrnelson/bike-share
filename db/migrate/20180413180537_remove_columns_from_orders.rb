class RemoveColumnsFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :quantity, :integer
    remove_column :orders, :order_num, :integer
    remove_column :orders, :item_id, :bigint
  end
end

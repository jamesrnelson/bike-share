class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :quantity
      t.integer :order_num
      t.integer :status, default: 0
      t.references :user, index: true, foreign_key: true
      t.references :item, index: true, foreign_key: true
      t.timestamps
    end
  end
end

class AddFullnameToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :fullname, :string
  end
end

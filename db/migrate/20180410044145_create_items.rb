class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :title
      t.text :description
      t.float :price
      t.integer :status, default: 1
      t.string :image, default: 'img_default.jpg'
      t.timestamps
    end
  end
end

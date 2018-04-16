class ChangeDatesInConditions < ActiveRecord::Migration[5.1]
  def change
    change_column :conditions, :date, 'text using date::date'
  end
end

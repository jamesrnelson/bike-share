class ChangeDatesInConditions < ActiveRecord::Migration[5.1]
  def change
    change_column :conditions, :date, 'date using date::date'
  end
end

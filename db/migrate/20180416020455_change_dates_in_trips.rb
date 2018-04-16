class ChangeDatesInTrips < ActiveRecord::Migration[5.1]
  def change
    change_column :trips, :start_date, 'text using start_date::date'
    change_column :trips, :end_date, 'text using end_date::date'
  end
end

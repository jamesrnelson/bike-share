class ChangeDateInStations < ActiveRecord::Migration[5.1]
  def change
    change_column :stations, :installation_date, 'date using installation_date::date'
  end
end

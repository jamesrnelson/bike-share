class ChangeTripForeignKeys < ActiveRecord::Migration[5.1]
  def change
    remove_column :trips, :start_station
    remove_column :trips, :end_station
    change_table :trips do |t|
      t.belongs_to :start_station, foreign_key: { to_table: :stations }
      t.belongs_to :end_station, foreign_key: { to_table: :stations }
    end
  end
end

class ChangeInstallationDateInStations < ActiveRecord::Migration[5.1]
  def change
    change_column :stations, :installation_date, :string
  end
end

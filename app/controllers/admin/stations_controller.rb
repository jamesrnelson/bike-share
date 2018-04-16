class Admin::StationsController < Admin::BaseController
  def new
    @station = Station.new
  end

  def create
    station = Station.new(station_params)
    if station.save
      flash[:success] = "Station #{station.id} was created"
      redirect_to station_path(station)
    else
      flash[:error] = 'Station was not created'
      redirect_to new_admin_station_path
    end
  end

  def edit
    @station = Station.find(params[:id])
  end

  def update
    station = Station.find(params[:id])
    if station.update(station_params)
      flash[:success] = "Station #{station.id} was updated"
      redirect_to station_path(station)
    else
      flash[:error] = "Station #{station.id} was not updated"
      redirect_to edit_admin_station_path
    end
  end

  def destroy
    station = Station.find(params[:id])
    if station.destroy
      flash[:success] = "Station #{station.id} was successfully deleted"
    else
      flash[:error] = "Station #{station.id} was not deleted"
    end
    redirect_to stations_path
  end

  private

  def station_params
    params.require(:station).permit(:name,
                                 :dock_count,
                                 :city,
                                 :installation_date)
  end
end

class Admin::TripsController < Admin::BaseController
  def edit
    @trip = Trip.find(params[:id])
    @stations = Station.alphabetize
  end

  def update
    trip = Trip.find(params[:id])
    if trip.update(trip_params)
      flash[:success] = "Trip #{trip.id} was updated"
      redirect_to trip_path(trip)
    else
      flash[:failure] = "Trip #{trip.id} was not updated"
      redirect_to edit_admin_trip_path
    end
  end

  def destroy
    trip = Trip.find(params[:id])
    if trip.destroy
      flash[:success] = "Trip #{trip.id} was successfully deleted"
    else
      flash[:failure] = "Trip #{trip.id} was not deleted"
    end
    redirect_to trips_path
  end

  private

  def trip_params
    params.require(:trip).permit(:duration,
                                 :start_date,
                                 :start_station_id,
                                 :end_date,
                                 :end_station_id,
                                 :bike_id,
                                 :subscription_type,
                                 :zip_code)
  end
end

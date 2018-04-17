class StationsController < ApplicationController
  def index
    @stations = Station.order(:name)
  end

  def show
    @station = Station.find_by(slug: params[:slug])
  end

  def dashboard
    @total = Station.total
    @avg_bikes = Station.avg_bikes
    @most_bike_stations = Station.most_bikes
    @fewest_bike_stations = Station.fewest_bikes
    @newest = Station.newest
    @oldest = Station.oldest
  end
end

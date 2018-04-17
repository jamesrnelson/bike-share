# Defines Trips Controller
class TripsController < ApplicationController
  def index
    limit = 30
    @pages = (Trip.all.size.to_f / limit).ceil
    offset = params[:offset].to_i * limit ||= 0
    @trips = Trip.all.offset(offset).limit(limit)
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def dashboard
    @most_conditions = Condition.most_rides
    @least_conditions = Condition.least_rides
    @duration_metrics = Trip.duration_metrics
    @most_starts = Station.most_starting_rides
    @most_ends = Station.most_ending_rides
    @rides_by_date = Trip.rides_by_date
    @bike_metrics = Trip.bike_metrics
    @subscription_metrics = Trip.subscription_metrics
  end
end

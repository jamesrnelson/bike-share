class StationsController < ApplicationController
  def index
    @stations = Station.order(:name)
  end

  def show
    @station = Station.find_by(slug: params[:slug])
  end
end

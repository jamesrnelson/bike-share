class ConditionsController < ApplicationController
  def index
    limit = 100
    @pages = (Condition.all.size.to_f / limit).ceil
    offset = params[:offset].to_i * limit ||= 0
    @conditions = Condition.all.offset(offset).limit(limit)
  end

  def show
    @condition = Condition.find(params[:id])
  end

  def dashboard
    @conditions = Condition.where(zip_code: 94107)
  end
end

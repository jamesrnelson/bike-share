class ConditionsController < ApplicationController
  def index
    limit = 100
    @pages = (Condition.all.size.to_f / limit).ceil
    offset = params[:offset].to_i * limit ||= 0
    if params[:sort]
      @conditions = Condition.all.order(params[:sort]).offset(offset).limit(limit)
    else
      @conditions = Condition.all.order('date DESC').offset(offset).limit(limit)
    end
  end

  def show
    @condition = Condition.find(params[:id])
  end

  def dashboard
    @conditions = Condition.where(zip_code: 94107)
  end
end

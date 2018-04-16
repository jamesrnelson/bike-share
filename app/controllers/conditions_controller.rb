class ConditionsController < ApplicationController
  def index
    @conditions = Condition.all
  end

  def show
    @condition = Condition.find(params[:id])
  end

  def dashboard
    @conditions = Condition.where(zip_code: 94107)
  end
end

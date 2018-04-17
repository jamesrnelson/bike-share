# Defines Admin Conditions Controller actions
class Admin::ConditionsController < Admin::BaseController
  def index
    @conditions = Condition.all
  end

  def new
    @condition = Condition.new
  end

  def create
    @condition = Condition.new(condition_params)
    if @condition.save
      flash[:success] = 'You have created new weather conditions.'
      redirect_to condition_path(@condition)
    else
      flash[:failure] = 'You were unable to create new weather conditions.'
      render :new
    end
  end

  def edit
    @condition = Condition.find(params[:id])
  end

  def update
    condition = Condition.find(params[:id])
    if condition.update(condition_params)
      flash[:success] = 'You have updated the weather conditions.'
      redirect_to condition_path(condition)
    else
      flash[:failure] = 'You were unable to update the weather conditions.'
      render :edit
    end
  end

  def show
    @condition = Condition.find(params[:id])
  end

  def destroy
    condition = Condition.find(params[:id])
    if condition.destroy
      flash[:success] = "You have successfully deleted the weather conditions for #{condition.date}."
    else
      flash[:failure] = "The weather conditions for #{condition.date} were NOT deleted."
    end
    redirect_to conditions_path
  end

  private

  def condition_params
    params.require(:condition).permit(
      :date,
      :max_temperature,
      :mean_temperature,
      :min_temperature,
      :mean_humidity,
      :mean_visibility,
      :mean_wind_speed,
      :precipitation,
      :zip_code
    )
  end
end

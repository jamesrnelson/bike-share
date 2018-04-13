# Defines Admin Conditions Controller actions
class Admin::ConditionsController < Admin::BaseController
  def index
    @conditions = Condition.all
  end

  def edit
    @condition = Condition.find(params[:id])
  end

  def update
    condition = Condition.find(params[:id])
    condition.update(condition_params)
    redirect_to admin_condition_path(condition)
  end

  def show
    @condition = Condition.find(params[:id])
    flash[:notice] = 'You have updated the weather conditions.'
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
      :mean_humdity,
      :mean_visibility,
      :mean_wind_speed,
      :precipitation
    )
  end
end

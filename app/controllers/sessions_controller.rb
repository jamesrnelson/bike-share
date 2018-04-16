class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_dashboard_path and return if current_admin?
      redirect_to dashboard_path
    else
      flash[:Error] = 'Incorrect Username or Password'
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    flash[:notice] = 'You have logged out'
    redirect_to root_path
  end
end

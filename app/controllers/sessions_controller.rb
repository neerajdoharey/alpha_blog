class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success]="Login Successfully"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Email or password is not correct"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success]="Logout Successfully"
    redirect_to root_path
  end
end

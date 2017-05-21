class UsersController < ApplicationController
  before_action :set_user, except: [:index, :new, :create ]
  before_action :required_same_user, only: [:edit, :update, :destroy]
  before_action :required_admin,  only: [:destroy]
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the alpha blog #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:success] = "Username details updated"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 2)
  end
  def destroy
    @user = User.find(params[:id])
    flash[:success] = "User Deleted and there related article deleted"
    @user.destroy
    redirect_to users_path
  end
  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  def required_same_user
    if current_user != @user && !current_user.admin?
      flash[:danger] = "You can update your own account information"
      redirect_to root_path
    end
  end

  def required_admin
    if logged_in? && !current_user.admin?
      flash[:danger] = "Admin User can perform this action"
      redirect_to user_path
    end
  end
end

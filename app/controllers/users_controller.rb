class UsersController < ApplicationController
  
  def current
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      flash[:danger] = "You must be logged in to do that."
      redirect_to login_path #redirect to login page
    end
    redirect_to user_path #user show page
  end

  def index
    @users = User.all 
  end

  def login_form
    @user = User.new
  end
  
  def login
    username = params[:user][:username]
    user = User.find_by(name: username)
    if user
      session[:user_id] = user.id
      flash[:success] = "Welcome back, #{username}!"
    else
      user = User.create(name: username)
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as new user #{username}"
    end
    redirect_to root_path
  end
    
  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out."
    redirect_to root_path
  end
  
  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to root_path
      return 
    end
  end
  
end

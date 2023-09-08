class UsersController < ApplicationController
  def show
    if current_user
    @user = User.find(params[:id])
    @facade = MoviePartyFacade.new
    else
    redirect_to root_path
    flash[:alert] = "Must Be logged in to View Page"
    end
  end

  def new
    @user = User.new
  end
  
  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "New User created successfully."
      redirect_to user_path(user)
    else 
      flash[:alert] = "#{error_message(user.errors)}"
      redirect_to new_register_path
    end
  end

  def login_form

  end

  def login_user
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to user_path(user)
    else
      flash[:error] = "Sorry, your credentials are bad."
      redirect_to login_path
    end
  end

  def logout
    session.delete(:user_id)
    redirect_to root_path
    flash[:success] = "Logged Out Succesfully"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation) 
  end
end
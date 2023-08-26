class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @facade = MoviePartyFacade.new
  end

  def new
    @user = User.new
  end
  
  def create
    user = User.new(user_params)
    if user.save
      flash[:success] = "New User created successfully."
      redirect_to user_path(user)
    else 
      flash[:alert] = "#{error_message(user.errors)}"
      redirect_to new_register_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email) 
  end
end
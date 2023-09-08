class ViewingPartyController < ApplicationController

  def new
    if current_user
      @user = User.find(params[:user_id])
      @users = User.all
      @movie_id = (params[:movie_id])
      @facade = MoviesDetailsFacade.new(@movie_id)
      @viewing = ViewingParty.new
    else 
      redirect_to root_path
      flash[:alert] = "Must Be logged in to View Page"
    end
  end
  
  def create
    movie_id = (params[:movie_id])
    user = User.find(params[:user_id])
    @users = User.all
    viewing = ViewingParty.new(view_params)
    if viewing.save
      @users.each do |user|
        if params[user.id.to_s] == "1"
          UserViewingParty.create!(user_id: user.id, viewing_party_id: viewing.id)
        end
      end
      flash[:success] = "New Viewing Party created successfully."
      redirect_to user_path(user)
    else 
      flash[:error] = "Viewing Party could not be created"
      redirect_to new_user_movie_viewing_party_path(user, movie_id)
    end
  end

  private

  def view_params
    params.permit(:duration, :date, :start_time, :movie_id) 
  end
end
class ViewingPartyController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @users = User.all
    @movie_id = (params[:movie_id])
    @facade = MoviesDetailsFacade.new(@movie_id)
    @viewing = ViewingParty.new
  end
  
  def create
    viewing = ViewingParty.new(user_params)
    user = User.find(params[:user_id])
    movie_id = (params[:movie_id])
    @users = User.all
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
      new_user_movie_viewing_party_path(user, movie_id)
    end
  end

  private

  def user_params
    params.permit(:duration, :date, :start_time) 
  end
end
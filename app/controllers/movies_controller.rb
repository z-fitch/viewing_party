class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @facade = MoviesSearchFacade.new(params[:search])
  
  end

  def show
    @user = User.find(params[:user_id])
    @movie_id = (params[:id])
    @facade = MoviesDetailsFacade.new(@movie_id)
  end
end
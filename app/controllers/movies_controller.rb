class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @facade = MoviesFacade.new(params[:search])
  end

  def show

  end
end
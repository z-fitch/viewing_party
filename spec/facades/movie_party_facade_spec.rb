require 'rails_helper'

RSpec.describe MoviePartyFacade do
  describe 'Instance Methods', :vcr do
    before :each do
      @facade = MoviePartyFacade.new
    end
    it 'exists' do
      expect(@facade).to be_a(MoviePartyFacade)
      expect(@facade.service).to be_a(MoviesService) #using Forrest Gump movie id
    end

    it 'returns movie details' do
      expect(@facade.movie_details(13)).to be_a(Movie)#using Forrest Gump movie id
    end

    it 'returns movie poster path' do
      expect(@facade.movie_poster_path(13)).to be_a(String) #using Forrest Gump movie id
      expect(@facade.movie_poster_path(13)).to eq("/zxzYh2YtgypKrijVE0OuIyEgwdT.jpg") #using Forrest Gump movie id
    end

    it 'returns the movie image url path' do
      expect(@facade.movie_image(13)).to eq("https://image.tmdb.org/t/p/w500/zxzYh2YtgypKrijVE0OuIyEgwdT.jpg") #using Forrest Gump movie id
    end
  end
end
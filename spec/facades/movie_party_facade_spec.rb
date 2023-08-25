require 'rails_helper'

RSpec.describe MoviePartyFacade do
  describe 'Instance Methods', :vcr do
    before :each do
      @facade = MoviePartyFacade.new(13) #using Forrest Gump movie id
    end
    it 'exists' do

      expect(@facade.movie_id).to eq(13)
      expect(@facade).to be_a(MoviePartyFacade)
      expect(@facade.service).to be_a(MoviesService)
    end

    it 'returns movie details' do
      expect(@facade.movie_details).to be_a(Movie)
    end

    it 'returns movie poster path' do
      expect(@facade.movie_poster_path).to be_a(String)
      expect(@facade.movie_poster_path).to eq("/zxzYh2YtgypKrijVE0OuIyEgwdT.jpg")
    end

    it 'returns the movie image url path' do
      expect(@facade.movie_image).to eq("https://image.tmdb.org/t/p/w500/zxzYh2YtgypKrijVE0OuIyEgwdT.jpg")
    end
  end
end
require 'rails_helper'

RSpec.describe MoviesService do
  describe 'Class Methods' do
    context '#top_20_rated', :vcr do
      it 'returns top rated movies' do
        top_movies = MoviesService.new.top_20_rated
        
        expect(top_movies).to be_a(Hash)
        expect(top_movies[:results]).to be_an(Array)
      end

      it "has the needed Movie Data" do
        top_movies = MoviesService.new.top_20_rated
        movie_data = top_movies[:results].first

        expect(movie_data).to have_key(:id)
        expect(movie_data[:id]).to be_an(Integer)

        expect(movie_data).to have_key(:title)
        expect(movie_data[:title]).to be_an(String)

        expect(movie_data).to have_key(:vote_average)
        expect(movie_data[:vote_average]).to be_a(Float)
      end
    end

    context '#search(title)', :vcr do
      it 'returns movies related to the title searched' do
        searched_movies = MoviesService.new.top_20_rated
        
        expect(searched_movies).to be_a(Hash)
        expect(searched_movies[:results]).to be_an(Array)
      end

      it "has the needed Movie Data" do
        searched_movies = MoviesService.new.top_20_rated
        movie_data = searched_movies[:results].first

        expect(movie_data).to have_key(:id)
        expect(movie_data[:id]).to be_an(Integer)

        expect(movie_data).to have_key(:title)
        expect(movie_data[:title]).to be_an(String)

        expect(movie_data).to have_key(:vote_average)
        expect(movie_data[:vote_average]).to be_a(Float)
      end
    end
  end
end
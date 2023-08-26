require 'rails_helper'

RSpec.describe MoviesService do
  describe 'Class Methods' do
    context '#top_20_rated', :vcr do
      it 'returns top rated movies' do
        top_movies = MoviesService.new.top_20_rated

        expect(top_movies).to be_a(Hash)
        expect(top_movies[:results]).to be_an(Array)
      end

      it 'has the needed Movie Data' do
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

      it 'has the needed Movie Data' do
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

    context '#details(id)', :vcr do
      it 'returns movies related to the title searched' do
        movie_details = MoviesService.new.details(13) # forrest gump id

        expect(movie_details).to be_a(Hash)
      end

      it 'has the needed Movie Data' do
        movie_details = MoviesService.new.details(13)

        expect(movie_details).to have_key(:id)
        expect(movie_details[:id]).to be_an(Integer)

        expect(movie_details).to have_key(:title)
        expect(movie_details[:title]).to be_an(String)

        expect(movie_details).to have_key(:vote_average)
        expect(movie_details[:vote_average]).to be_a(Float)

        expect(movie_details).to have_key(:genres)
        expect(movie_details[:genres]).to be_a(Array)

        expect(movie_details).to have_key(:overview)
        expect(movie_details[:overview]).to be_a(String)

        expect(movie_details).to have_key(:runtime)
        expect(movie_details[:runtime]).to be_a(Integer)
      end
    end

    context '#reviews(id)', :vcr do
      it 'returns movies related to the title searched' do
        movie_reviews = MoviesService.new.reviews(13)

        expect(movie_reviews).to be_a(Hash)
        expect(movie_reviews[:results]).to be_a(Array)
      end

      it 'has the needed Movie Data' do
        movie_reviews = MoviesService.new.reviews(13)
        movie_data = movie_reviews[:results].first

        expect(movie_data).to have_key(:author)
        expect(movie_data[:author]).to be_an(String)

        expect(movie_data).to have_key(:content)
        expect(movie_data[:content]).to be_an(String)
      end
    end

    context '#credits(id)', :vcr do
      it 'returns movies related to the title searched' do
        movie_credits = MoviesService.new.credits(13)

        expect(movie_credits).to be_a(Hash)
        expect(movie_credits[:cast]).to be_a(Array)
      end

      it 'has the needed Movie Data' do
        movie_credits = MoviesService.new.credits(13)
        movie_data = movie_credits[:cast].first

        expect(movie_data).to have_key(:name)
        expect(movie_data[:name]).to be_an(String)

        expect(movie_data).to have_key(:character)
        expect(movie_data[:character]).to be_an(String)
      end
    end

    context '#credits(id)', :vcr do
      it 'returns movies related to the title searched' do
        movie_credits = MoviesService.new.poster(13)
        expect(movie_credits).to be_a(Hash)
        expect(movie_credits[:posters]).to be_a(Array)
      end

      it 'has the needed Movie Data' do
        movie_credits = MoviesService.new.poster(13)
        movie_data = movie_credits[:posters].first

        expect(movie_data).to have_key(:file_path)
        expect(movie_data[:file_path]).to be_an(String)
      end
    end
  end
end

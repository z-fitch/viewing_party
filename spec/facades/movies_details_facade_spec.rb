require 'rails_helper'

RSpec.describe MoviesDetailsFacade do
  describe 'Instance Methods', :vcr do
    it 'exists' do
      facade1 = MoviesDetailsFacade.new(13)

      expect(facade1.movie_id).to eq(13)
      expect(facade1).to be_a(MoviesDetailsFacade)
      expect(facade1.service).to be_a(MoviesService)
    end

    it 'returns movie details' do
      facade1 = MoviesDetailsFacade.new(13) # forrest gump id

      expect(facade1.movie_details).to be_a(Movie)
    end

    it 'returns movie actors' do
      facade1 = MoviesDetailsFacade.new(13)

      expect(facade1.movie_actors.first).to be_a(Actor)
    end

    it 'returns movie reviews' do
      facade1 = MoviesDetailsFacade.new(13)

      expect(facade1.movie_reviews.first).to be_a(Review)
    end

    it 'can count number of movies' do
      facade1 = MoviesDetailsFacade.new(13)

      expect(facade1.movie_review_count).to eq(2)
    end
  end
end

require 'rails_helper'

RSpec.describe MoviesSearchFacade do
  describe 'Instance Methods', :vcr do
    it 'exists' do
      facade1 = MoviesSearchFacade.new('clueless')

      expect(facade1.query).to eq('clueless')
      expect(facade1).to be_a(MoviesSearchFacade)
      expect(facade1.service).to be_a(MoviesService)
    end

    it 'returns movies' do
      facade1 = MoviesSearchFacade.new('Top Rated')
      facade2 = MoviesSearchFacade.new('clueless')

      facade1.movies.each do |movie|
        expect(movie).to be_a(Movie)
      end

      facade2.movies.each do |movie|
        expect(movie).to be_a(Movie)
      end
    end

    it 'can count number of movies' do
      facade = MoviesSearchFacade.new('Top Rated')

      expect(facade.movies_count).to eq(20)
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Movie detail page', type: :feature do
  describe 'When I visit the movies details page' do
    before :each do
      @user = create(:user)

      json_response_search = File.read('spec/fixtures/movie_search_info.json')
      stub_request(:get, 'https://api.themoviedb.org/3/search/movie?query=forrest+gump')
        .with(
          headers: {
            'Authorization' => Rails.application.credentials.tmdb[:access_token]
          }
        )
        .to_return(status: 200, body: json_response_search)
      response_search = JSON.parse(json_response_search, symbolize_names: true)
      @movie_search = response_search[:results].first

      json_response_details = File.read('spec/fixtures/movie_details.json')
      stub_request(:get, "https://api.themoviedb.org/3/movie/#{@movie_search[:id]}")
        .with(
          headers: {
            'Authorization' => Rails.application.credentials.tmdb[:access_token]
          }
        )
        .to_return(status: 200, body: json_response_details)
      response_details = JSON.parse(json_response_details, symbolize_names: true)
      @movie_details = response_details

      json_response_reviews = File.read('spec/fixtures/movie_reviews.json')
      stub_request(:get, "https://api.themoviedb.org/3/movie/#{@movie_search[:id]}/reviews")
        .with(
          headers: {
            'Authorization' => Rails.application.credentials.tmdb[:access_token]
          }
        )
        .to_return(status: 200, body: json_response_reviews)
      response_reviews = JSON.parse(json_response_reviews, symbolize_names: true)
      @movie_reviews = response_reviews

      json_response_credits = File.read('spec/fixtures/movie_credits.json')
      stub_request(:get, "https://api.themoviedb.org/3/movie/#{@movie_search[:id]}/credits")
        .with(
          headers: {
            'Authorization' => Rails.application.credentials.tmdb[:access_token]
          }
        )
        .to_return(status: 200, body: json_response_credits)
      response_credits = JSON.parse(json_response_credits, symbolize_names: true)
      @movie_credits = response_credits

      visit user_movie_path(@user, @movie_search[:id])
    end

    it 'has a button to create a viewing party' do
      expect(page).to have_button("Create Viewing Party for #{@movie_search[:title]}") # TODO: make viewing parties :')
    end

    it 'has button to go to the discover page' do
      expect(page).to have_button('Discover Page')

      click_button('Discover Page')

      expect(current_path).to eq(user_discover_index_path(@user))
    end

    it 'has the movie title, genre, runtime, vote average, and overview(summary)' do
      genres = @movie_details[:genres].map do |genre|
        genre[:name]
      end.join(', ')

      runtime = @movie_details[:runtime]
      expect(page).to have_content(@movie_details[:title])
      expect(page).to have_content(genres)
      expect(page).to have_content("#{runtime / 60}hr #{runtime % 60}min")
      expect(page).to have_content(@movie_details[:vote_average])
      expect(page).to have_content(@movie_details[:overview])
    end

    it 'has the movie count of reviews, the reviewer authors name and content' do
      expect(page).to have_content(@movie_reviews[:total_results])

      @movie_reviews[:results].each do |review|
        expect(page).to have_content(review[:author_details][:username])
        expect(page).to have_content(review[:content])
      end
    end

    it 'has the list of the first ten actors in the movie' do
      @movie_credits[:cast].first(10).each do |actor|
        expect(page).to have_content(actor[:character])
        expect(page).to have_content(actor[:name])
      end

      expect(page).to have_css('#actors', count: 10)
    end
  end
end

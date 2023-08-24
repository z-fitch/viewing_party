# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Movies Page', type: :feature do
  before :each do
    @user = create(:user)
  end

  describe 'Top Rated Movie Results Page' do
    scenario 'click on the Discover Top Rated Movies button', :vcr do
      visit user_discover_index_path(@user)
      click_link 'Discover Top Rated Movies'

      expect(current_path).to eq(user_movies_path(@user))
      expect(page).to have_css('.movie', count: 20)
      expect(page).to have_css('.movie-title', count: 20)
      expect(page).to have_css('.movie-vote-avg', count: 20)

      expect(page).to_not have_css('.movie', count: 21)
      expect(page).to_not have_css('.movie', count: 19)

      expect(page).to have_content('Showing 20 Results')
    end

    it 'has a Discover Page button', :vcr do
      visit user_movies_path(@user)

      expect(page).to have_button('Discover Page')

      click_button 'Discover Page'

      expect(current_path).to eq(user_discover_index_path(@user))
    end
  end

  describe 'Movies by Search Results Page' do
    scenario 'search by title', :vcr do
      visit user_discover_index_path(@user)

      fill_in :search, with: 'clueless'
      click_button 'Search'

      expect(current_path).to eq(user_movies_path(@user))

      expect(page).to have_css('.movie', count: 9)
      expect(page).to have_css('.movie-title', count: 9)
      expect(page).to have_css('.movie-vote-avg', count: 9)
      expect(page).to have_content('Showing 9 Results')
    end
  end

  describe 'Movie Titles link to Details', :vcr do
    scenario 'Movie Titles are links' do
      visit user_discover_index_path(@user)
      click_link 'Discover Top Rated Movies'

      expect(page).to have_css('a.movie-title', count: 20)
    end
  end
end

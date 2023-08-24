# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Discover Movies Page', type: :feature do
  describe 'When I visit the (/users/:id/discover)' do
    before :each do
      @user = create(:user)

      visit user_discover_index_path(@user)
    end

    it 'has button to discover top rated movies' do
      expect(page).to have_button('Discover Top Rated Movies')
    end

    it 'has a search field and button to find relevant movies' do
      within('#search-movies') do
        expect(page).to have_field(:search)
        expect(page).to have_button('Search')
      end
    end
  end
end

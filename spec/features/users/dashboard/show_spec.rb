# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Dashboard', type: :feature do
  before :each do
    @user = create(:user)
    @user2 = create(:user)

    @movie = Movie.new({id: 13, title: 'Forrest Gump'})
    @movie2 = Movie.new({id: 200, title: 'Star Trek: The Next Generation Collection'})

    @viewing_party = ViewingParty.create!({duration: 142, date: Date.today, start_time: Time.now, movie_id: @movie.id})

    @viewing_party_2 = ViewingParty.create!({duration: 84, date: Date.today, start_time: Time.now, movie_id: @movie2.id})

    @uvp_1 = UserViewingParty.create!(user_id: @user.id, viewing_party_id: @viewing_party.id)
    @uvp_2 = UserViewingParty.create!(user_id: @user2.id, viewing_party_id: @viewing_party.id, host: true)

    @uvp_3 = UserViewingParty.create!(user_id: @user.id, viewing_party_id: @viewing_party_2.id, host: true)
    @uvp_4 = UserViewingParty.create!(user_id: @user2.id, viewing_party_id: @viewing_party_2.id)


    visit user_path(@user)
  end

  describe 'When I visit (/users/:id)', :vcr do
    it 'displays <usernames dashboard>' do
      expect(page).to have_content("#{@user.name}'s Dashboard", count: 1)
      expect(page).to_not have_content("#{@user2.name}'s Dashboard")
    end

    it 'Has a button to "Discover Movies" page' do
      expect(page).to have_button('Discover Movies')

      click_link 'Discover Movies'

      expect(current_path).to eq(user_discover_index_path(@user))
    end

    it 'Has a section that lists viewing parties' do
      expect(page).to have_content('Upcoming Viewing Parties')
      expect(page).to have_css('.user-dash-parties-container')
    end

    it 'shows viewing parties user has been invited to' do
      within("#viewing-party-card-#{@viewing_party.id}") do
        expect(page).to have_content(@movie.title)
        expect(page).to have_content(@viewing_party.host)
        expect(page).to have_content(@viewing_party.date.strftime("%m/%d/%Y"))
        expect(page).to have_content(@viewing_party.start_time.strftime("%I:%M%p"))
      end
    end

    it 'shows a list of users invited to the viewing party' do
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user2.name)
    end
  end
end

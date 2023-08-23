require 'rails_helper'

RSpec.describe 'User Dashboard', type: :feature do
  before :each do
    @user = create(:user)
    @user2 = create(:user)
    
    visit user_path(@user)
  end

  describe 'When I visit (/users/:id)' do
    it 'displays <usernames dashboard>' do
      expect(page).to have_content("#{@user.name}'s Dashboard", count: 1)
      expect(page).to_not have_content("#{@user2.name}'s Dashboard")
    end

    it 'Has a button to "Discover Movies" page' do
      expect(page).to have_button("Discover Movies")

      click_link "Discover Movies"

      expect(current_path).to eq(user_discover_index_path(@user))
    end

    it "Has a section that lists viewing parties" do
      expect(page).to have_content("Upcoming Viewing Parties")
      expect(page).to have_css(".user-dash-parties-container")
    end
  end
end
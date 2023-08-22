require "rails_helper"

RSpec.describe "Welcome Page", type: :feature do
  describe "When visiting the root path '/'" do 
    it "has the title of the application" do 
      visit root_path

      within("div#title") do 
        expect(page).to have_content("Viewing Party")
      end
    end

    it "has a button to create a new user" do 
      visit root_path

      within("div#user-creation") do 
        expect(page).to have_button("Create A New User")
        click_button("Create A New User")
      end

      expect(current_path).to eq(new_user_path)
    end

    xit "has a list of the Existing Users" do 

    end
  end
end
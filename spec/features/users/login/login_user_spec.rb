require 'rails_helper'

RSpec.describe "User Can log in" do
  it 'has a link that take me to a log in page' do 
    visit root_path

    expect(page).to have_link("Log In", href: login_path)
  end

  it 'it takes you to the log in page where it has an email feild and a password field' do 
    visit root_path

    expect(page).to have_link("Log In", href: login_path)

    click_link("Log In")

    expect(current_path).to eq(login_path)

    expect(page).to have_field('Email')
    expect(page).to have_field('Password')

    expect(page).to have_button("Log In")
  end

  it "can log in when an existing user fills in form with correct info" do
    user = User.create!(name: 'Michael', email: 'fakeemail@email.com', password: 'testing123', password_confirmation: 'testing123')

    visit login_path

    fill_in :email, with: "fakeemail@email.com"
    fill_in :password, with: "testing123"

    click_on "Log In"

    expect(current_path).to eq(user_path(user))

    expect(page).to have_content("Welcome, #{user.name}")
  end

  it "can log in when an existing user fills in form with Incorrect info they get an error" do
    User.create!(name: 'Michael', email: 'fakeemail@email.com', password: 'testing123', password_confirmation: 'testing123')

    visit login_path

    fill_in :email, with: "fakeemail@email.com"
    fill_in :password, with: "BOO a password"

    click_on "Log In"

    expect(current_path).to eq(login_path)

    expect(page).to have_content("Sorry, your credentials are bad.")
  end

  it "can log in when an existing user fills in form with Incorrect info they get an error" do
    User.create!(name: 'Michael', email: 'fakeemail@email.com', password: 'testing123', password_confirmation: 'testing123')

    visit login_path

    fill_in :email, with: "fakeemail02@email.com"
    fill_in :password, with: "testing123"

    click_on "Log In"

    expect(current_path).to eq(login_path)

    expect(page).to have_content("Sorry, your credentials are bad.")
  end

  describe "the user can log out" do 
    it 'has a log out button if the user has already logged in' do 
      User.create!(name: 'Michael', email: 'fakeemail@email.com', password: 'testing123', password_confirmation: 'testing123')

      visit login_path
  
      fill_in :email, with: "fakeemail@email.com"
      fill_in :password, with: "testing123"
  
      click_on "Log In"

      click_on "Home"

      expect(current_path).to eq(root_path)
      expect(page).to have_link("Log Out")
      expect(page).to_not have_link("Create A New User")
      expect(page).to_not have_link("Log In")
    end

    it "can log the user out if log out is clicked"do 
      User.create!(name: 'Michael', email: 'fakeemail@email.com', password: 'testing123', password_confirmation: 'testing123')

      visit login_path
  
      fill_in :email, with: "fakeemail@email.com"
      fill_in :password, with: "testing123"
  
      click_on "Log In"
      click_on "Home"
      click_on "Log Out"

      expect(current_path).to eq(root_path)
      expect(page).to_not have_link("Log Out")
      expect(page).to have_button("Create A New User")
      expect(page).to have_link("Log In")
    end

    it 'will now show me the list of users' do 
      user = User.create!(name: 'Michael', email: 'fakeemail@email.com', password: 'testing123', password_confirmation: 'testing123')
      
      visit root_path

      expect(page).to have_button("Create A New User")
      expect(page).to have_link("Log In")

      expect(page).to_not have_content("Existing Users")
      expect(page).to_not have_content(user.email)
      
      visit login_path
  
      fill_in :email, with: "fakeemail@email.com"
      fill_in :password, with: "testing123"
  
      click_on "Log In"
      click_on "Home"

      expect(page).to_not have_button("Create A New User")
      expect(page).to_not have_link("Log In")

      expect(page).to have_content("Existing Users")
      expect(page).to have_content(user.email)

    end
  end
  describe 'if the user has not logged in they wont have access to some parts' do 
    it 'wont let them see existing users' do 
      user = User.create!(name: 'Michael', email: 'fakeemail@email.com', password: 'testing123', password_confirmation: 'testing123')
      visit root_path

      expect(page).to have_button("Create A New User")
      expect(page).to have_link("Log In")

      expect(page).to_not have_content("Existing Users")
      expect(page).to_not have_content(user.email)
    end

    it 'wont let them go to a user dahsboard' do 
      user = User.create!(name: 'Michael', email: 'fakeemail@email.com', password: 'testing123', password_confirmation: 'testing123')
      
      visit user_path(user)

      expect(current_path).to eq(root_path)
      expect(current_path).to_not eq(user_path(user))
      expect(page).to have_content("Must Be logged in to View Page")
    end

    it 'wont let them create a viewing party if they go to the movie show page' do 
      user = User.create!(name: 'Michael', email: 'fakeemail@email.com', password: 'testing123', password_confirmation: 'testing123')
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

      visit user_movie_path(user, @movie_search[:id])
      
      click_button("Create Viewing Party for Forrest Gump")

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Must Be logged in to View Page")
    end
  end
end
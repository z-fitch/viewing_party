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
end
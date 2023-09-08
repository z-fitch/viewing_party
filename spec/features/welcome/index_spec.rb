# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Welcome Page', type: :feature do
  before :each do
    @user_1 = User.create!(name: 'Michael', email: 'michaelisvcool@email.com', password: 'password123', password_confirmation: 'password123')
    @user_2 = User.create!(name: 'Sara', email: 'sara1234@email.com', password: 'password123', password_confirmation: 'password123')
    @user_3 = User.create!(name: 'Elena', email: 'iheartmydogs@email.com', password: 'password123', password_confirmation: 'password123')
  end

  describe "When visiting the root path '/'" do
    it 'has the title of the application' do
      visit root_path

      within('div#title') do
        expect(page).to have_content('Viewing Party')
      end
    end

    it 'has a list of the Existing Users' do
      visit login_path

      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password
      click_button 'Log In'


      visit root_path

      expect(page).to have_content('michaelisvcool@email.com')
      expect(page).to have_content('sara1234@email.com')
      expect(page).to have_content('iheartmydogs@email.com')
    end

    it 'Each user listed is a link to that users dashboards' do
      visit login_path

      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password
      click_button 'Log In'

      visit root_path

      expect(page).to have_content(@user_1.email)
      expect(page).to have_content(@user_2.email)
      expect(page).to have_content(@user_3.email)
    end

    it "has a link to go to the home page '/' " do
      visit root_path

      within('#nav-bar') do
        expect(page).to have_link('Home', href: root_path)
      end
    end

    it 'has a button to create a new user' do
      visit root_path

      within('div#user-creation') do
        expect(page).to have_button('Create A New User')
        click_button('Create A New User')
      end

      expect(current_path).to eq(new_register_path)
    end

    it 'takes the user to a form to create an account' do
      visit root_path
      click_button('Create A New User')

      expect(page).to have_content('Register a New User')
      expect(page).to have_field('Name')
      expect(page).to have_field('Email')
      expect(page).to have_field('Password')
      expect(page).to have_field('Password Confirmation')

      expect(page).to have_button('Create User')
    end

    it 'When I fill in the form with valid info I am taken to the new users page' do
      visit root_path
      click_button('Create A New User')

      fill_in('Name', with: 'Name')
      fill_in('Email', with: 'NameLast@gmail.com')
      fill_in(:user_password, with: 'test123')
      fill_in( :user_password_confirmation, with: 'test123')

      click_button('Create User')

      expect(current_path).to_not eq(root_path)
    end

    it 'When I fill in the form with Invalid info, I am redirect to the form' do
      visit root_path
      click_button('Create A New User')

      fill_in('Name', with: '')
      fill_in('Email', with: 'NameLast@gmail.com')
      fill_in(:user_password, with: 'test123')
      fill_in( :user_password_confirmation, with: 'test123')

      click_button('Create User')

      expect(current_path).to eq(new_register_path)
      expect(page).to have_content("Name can't be blank")
    end

    it 'When I fill in the form with Invalid info, I am redirect to the form' do
      visit root_path
      click_button('Create A New User')

      fill_in('Name', with: 'Name')
      fill_in('Email', with: '')
      fill_in(:user_password, with: 'test123')
      fill_in( :user_password_confirmation, with: 'test123')

      click_button('Create User')

      expect(current_path).to eq(new_register_path)
      expect(page).to have_content("Email can't be blank")
    end

    it 'When I fill in the form with an email that already exists, I get an error and the user wont be created' do
      visit root_path
      click_button('Create A New User')

      fill_in('Name', with: 'Name')
      fill_in('Email', with: 'FakeEmail@gmail.com')
      fill_in(:user_password, with: 'test123')
      fill_in(:user_password_confirmation, with: 'test123')

      click_button('Create User')

      visit root_path
      click_on("Log Out")
      click_button('Create A New User')

      fill_in('Name', with: 'Second Name')
      fill_in('Email', with: 'FakeEmail@gmail.com')
      fill_in(:user_password, with: 'test1234')
      fill_in(:user_password_confirmation, with: 'test1234')
    
      click_button('Create User')

      expect(current_path).to eq(new_register_path)
      expect(page).to have_content('Email has already been taken')
    end

    it 'When I fill in the form with not mathcing passwords, I am redirect to the form with an error' do
      visit root_path
      click_button('Create A New User')

      fill_in('Name', with: 'Name')
      fill_in('Email', with: 'FakeEmail@gmail.com')
      fill_in(:user_password, with: 'test123')
      fill_in( :user_password_confirmation, with: 'test321')

      click_button('Create User')

      expect(current_path).to eq(new_register_path)
      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    it 'When I fill in the form with Valid info with matching passwords i am directed to the user dashboard' do
      visit root_path
      click_button('Create A New User')

      fill_in('Name', with: 'User')
      fill_in('Email', with: 'NameLast@gmail.com')
      fill_in(:user_password, with: 'test123')
      fill_in( :user_password_confirmation, with: 'test123')

      click_button('Create User')

      expect(current_path).to_not eq(root_path)
    end
  end
end

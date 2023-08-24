# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Welcome Page', type: :feature do
  before :each do
    # Implement Factory Bot here
    @user_1 = User.create!(name: 'Michael', email: 'michaelisvcool@email.com')
    @user_2 = User.create!(name: 'Sara', email: 'sara1234@email.com')
    @user_3 = User.create!(name: 'Elena', email: 'iheartmydogs@email.com')
  end

  describe "When visiting the root path '/'" do
    it 'has the title of the application' do
      visit root_path

      within('div#title') do
        expect(page).to have_content('Viewing Party')
      end
    end

    it 'has a list of the Existing Users' do
      visit root_path

      within('div#all-users') do
        expect(page).to have_content('michaelisvcool@email.com')
        expect(page).to have_content('sara1234@email.com')
        expect(page).to have_content('iheartmydogs@email.com')
      end
    end

    it 'Each user listed is a link to that users dashboards' do
      visit root_path

      within('div#all-users') do
        expect(page).to have_link(@user_1.email, href: user_path(@user_1))
        expect(page).to have_link(@user_2.email, href: user_path(@user_2))
        expect(page).to have_link(@user_3.email, href: user_path(@user_3))
      end
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
      expect(page).to have_button('Create User')
    end

    it 'When I fill in the form with valid info I am taken to the new users page' do
      visit root_path
      click_button('Create A New User')

      fill_in('Name', with: 'Name')
      fill_in('Email', with: 'NameLast@gmail.com')

      click_button('Create User')

      expect(current_path).to_not eq(root_path)
    end

    it 'When I fill in the form with Invalid info, I am redirect to the form' do
      visit root_path
      click_button('Create A New User')

      fill_in('Name', with: '')
      fill_in('Email', with: 'NameLast@gmail.com')

      click_button('Create User')

      expect(current_path).to eq(new_register_path)
      expect(page).to have_content("Name can't be blank")
    end

    it 'When I fill in the form with Invalid info, I am redirect to the form' do
      visit root_path
      click_button('Create A New User')

      fill_in('Name', with: 'Name')
      fill_in('Email', with: '')

      click_button('Create User')

      expect(current_path).to eq(new_register_path)
      expect(page).to have_content("Email can't be blank")
    end

    it 'When I fill in the form with an email that already exists, I get an error and the user wont be created' do
      visit root_path
      click_button('Create A New User')

      fill_in('Name', with: 'Name')
      fill_in('Email', with: 'FakeEmail@gmail.com')

      click_button('Create User')

      visit root_path

      click_button('Create A New User')

      fill_in('Name', with: 'Second Name')
      fill_in('Email', with: 'FakeEmail@gmail.com')

      click_button('Create User')

      expect(current_path).to eq(new_register_path)
      expect(page).to have_content('Email has already been taken')
    end
  end
end

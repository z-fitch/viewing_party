# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many :user_viewing_parties }
    it { should have_many :viewing_parties }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password)}
    it { should have_secure_password }

    it 'creates a password' do
      user = User.create(name: 'Meg', email: 'meg@test.com', password: 'password123', password_confirmation: 'password123')
      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq('password123')
    end
  end

  describe 'instance methods' do
    it '#movie_party_ids' do
      user = User.create!(name: "Bob", email: "bob@example.com", password: 'password123', password_confirmation: 'password123')
      viewing_party = ViewingParty.create!({duration: 142, date: Date.today, start_time: Time.now, movie_id: 13})
      viewing_party_2 = ViewingParty.create!({duration: 84, date: Date.today, start_time: Time.now, movie_id: 200})
      UserViewingParty.create!(user_id: user.id, viewing_party_id: viewing_party.id)
      UserViewingParty.create!(user_id: user.id, viewing_party_id: viewing_party_2.id, host: true)

      expect(user.movie_party_ids).to eq([13, 200])
    end
  end
end

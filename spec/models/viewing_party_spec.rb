require 'rails_helper'

RSpec.describe ViewingParty, type: :model do
  describe 'Associations' do
    it { should have_many :user_viewing_parties }
    it { should have_many :users }
  end

  describe 'Validations' do
    it { should validate_presence_of :date }
    it { should validate_presence_of :start_time }
    it { should validate_numericality_of :duration }
  end
end
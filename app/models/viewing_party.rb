class ViewingParty < ApplicationRecord
  has_many :user_viewing_parties
  has_many :users, through: :user_viewing_parties

  validates_presence_of :date, :start_time, :movie_id
  validates_numericality_of :duration

  def host
    users.joins(:user_viewing_parties)
      .find_by(user_viewing_parties: {host: true})
      .name
  end
end
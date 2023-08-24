require 'rails_helper'

RSpec.describe Movie do
  it 'exists' do
    attributes = {
      id: 1234,
      title: "Clueless",
      vote_average: 8.7
    }

    movie = Movie.new(attributes)

    expect(movie).to be_a(Movie)
    expect(movie.id).to eq(1234)
    expect(movie.title).to eq("Clueless")
    expect(movie.vote_average).to eq(8.7)
  end
end
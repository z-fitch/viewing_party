require 'rails_helper'

RSpec.describe Movie do
  it 'exists' do
    attributes = {
      id: 1234,
      title: 'Clueless',
      vote_average: 8.7
    }

    movie = Movie.new(attributes)

    expect(movie).to be_a(Movie)
    expect(movie.id).to eq(1234)
    expect(movie.title).to eq('Clueless')
    expect(movie.vote_average).to eq(8.7)
  end

  it 'exists for another end point' do
    attributes = {
      id: 1234,
      title: 'Clueless',
      vote_average: 8.7,
      genres: [{ "id": 35, "name": 'Comedy' }, { "id": 18, "name": 'Drama' }, { "id": 10_749, "name": 'Romance' }],
      overview: 'SO MUCH wow',
      runtime: 142
    }

    movie = Movie.new(attributes)

    expect(movie).to be_a(Movie)
    expect(movie.genres).to eq([{ "id": 35, "name": 'Comedy' }, { "id": 18, "name": 'Drama' },
                                { "id": 10_749, "name": 'Romance' }])
    expect(movie.overview).to eq('SO MUCH wow')
    expect(movie.runtime).to eq(142)
  end

  it 'can create a genre list' do
    attributes = {
      id: 1234,
      title: 'Clueless',
      vote_average: 8.7,
      genres: [{ "id": 35, "name": 'Comedy' }, { "id": 18, "name": 'Drama' }, { "id": 10_749, "name": 'Romance' }],
      overview: 'SO MUCH wow',
      runtime: 142
    }

    movie = Movie.new(attributes)

    expect(movie.genre_list).to eq('Comedy, Drama, Romance')
  end

  it 'can format runtime with hours and minutes' do
    attributes = {
      id: 1234,
      title: 'Clueless',
      vote_average: 8.7,
      genres: [{ "id": 35, "name": 'Comedy' }, { "id": 18, "name": 'Drama' }, { "id": 10_749, "name": 'Romance' }],
      overview: 'SO MUCH wow',
      runtime: 142
    }

    movie = Movie.new(attributes)

    expect(movie.format_runtime).to eq('2hr 22min')
  end
end

class Movie
  attr_reader :id, 
              :title, 
              :vote_average,
              :genres,
              :overview,
              :runtime

  def initialize(movie_info)
    @id = movie_info[:id]
    @title = movie_info[:title]
    @vote_average = movie_info[:vote_average]
    @genres = movie_info[:genres] 
    @overview = movie_info[:overview] 
    @runtime = movie_info[:runtime]
  end

  def genre_list
    @genres.map do |genre|
      genre[:name]
    end.join(", ")
  end

  def format_runtime
    " #{@runtime/ 60}hr #{@runtime % 60}min"    
  end
end
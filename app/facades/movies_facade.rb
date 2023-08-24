class MoviesFacade

  def initialize(query)
    @query = query
  end

  def movies
    if @query == "top+rated"
      self.top_rated
    else
      search_movies(@query)
    end
  end

  def top_rated 
    service = MoviesService.new
    json = service.top_20_rated 
    @movies = json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def search_movies(query)
    service = MoviesService.new
    json = service.search(query)
    @movies = json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end
end
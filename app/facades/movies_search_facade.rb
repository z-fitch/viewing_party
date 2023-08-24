class MoviesSearchFacade
  attr_reader :query
  def initialize(query)
    @query = query
    @service = MoviesService.new
  end

  def movies_count
    movies_data.count
  end

  def movies_data
    @_movies_data ||= movies
  end

  def movies
    if @query == "Top Rated"
      self.top_rated
    else
      self.searched_movies(@query)
    end
  end

  def top_rated 
    json = @service.top_20_rated 
    create_movies(json)
  end

  def searched_movies(query)
    json = @service.search(query)
    create_movies(json)
  end

  def create_movies(json)
    json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end
end
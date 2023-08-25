class MoviePartyFacade
  attr_reader :movie_id, :service

  def initialize(id)
    @movie_id = id
    @service = MoviesService.new
  end

  def movie_details
    json = @service.details(@movie_id)
    Movie.new(json)
  end

  def movie_poster_path
    json = @service.poster(@movie_id)
    json[:posters].first[:file_path]
  end
  
  def movie_image
    "https://image.tmdb.org/t/p/w500#{movie_poster_path}"
  end
end
class MoviePartyFacade
  attr_reader :service

  def initialize
    @service = MoviesService.new
  end

  def movie_details(id)
    json = @service.details(id)
    Movie.new(json)
  end

  def movie_poster_path(id)
    json = @service.poster(id)
    json[:posters].first[:file_path]
  end
  
  def movie_image(id)
    "https://image.tmdb.org/t/p/w500#{movie_poster_path(id)}"
  end
end
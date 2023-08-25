class MoviesDetailsFacade
  attr_reader :movie_id, :service

  def initialize(id)
    @movie_id = id
    @service = MoviesService.new
  end
  
  def movie_details
    json = @service.details(@movie_id)
    Movie.new(json)
  end

  def movie_actors
    json = @service.credits(@movie_id)
    json[:cast].first(10).map do |actor_data|
      Actor.new(actor_data)
    end
  end
  
  def movie_reviews
    json = reviews_data
    json[:results].map do |review_data|
      Review.new(review_data)
    end
  end

  def movie_review_count
    json = reviews_data
    json[:total_results]
  end

  private 

  def reviews_data
    @_reviews_data ||= @service.reviews(@movie_id)
  end
end
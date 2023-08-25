class MoviesDetailsFacade
  attr_reader :movie_id

  def initialize(id)
    @movie_id = id
    @service = MoviesService.new
  end

  # def all_movie_info
  # movie_details
  # movie_reviews
  # movie_actors
  # # x[:details].title => "Forrest Gump"
  # # x[:reviews] => [#<Review:0x000000010a985728 @author="llgolden", @content="Best movie ever.">, #<Review:0x000000010a9856d8 @author="bluedevil667", @content="This is the best movie ever!">]
  # # x[:actors] => [#<Actor:0x000000010a9ecf90 @character="Forrest Gump", @name="Tom Hanks">, #<Actor:0x000000010a9ecf40 @character="Jenny Curran", @name="Robin Wright">,
  # end
  
  def movie_details
    json = @service.details(@movie_id)
    Movie.new(json)
  end

  def movie_reviews
    json = @service.reviews(@movie_id)
    json[:results].map do |review_data|
      Review.new(review_data)
    end
  end

  def movie_review_count
    json = @service.reviews(@movie_id)
    json[:total_results]
  end
  
  def movie_actors
    json = @service.credits(@movie_id)
    json[:cast].first(10).map do |actor_data|
      Actor.new(actor_data)
    end
  end
end
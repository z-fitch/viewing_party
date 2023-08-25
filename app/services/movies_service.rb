class MoviesService

  def search(title)
    get_url("/3/search/movie?query=#{title}")
  end

  def top_20_rated
    get_url("/3/movie/top_rated")
  end

  def details(id)
    get_url("https://api.themoviedb.org/3/movie/#{id}")
  end

  def reviews(id)
    get_url("https://api.themoviedb.org/3/movie/#{id}/reviews")
  end

  def credits(id)
    get_url("https://api.themoviedb.org/3/movie/#{id}/credits")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.headers["Authorization"] = Rails.application.credentials.tmdb[:access_token]
    end
  end
end
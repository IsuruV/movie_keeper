class MovieSearcher
  attr_accessor :movie
  def initialize
    api_key = "e3245d0128a1ccf69e3fab0a65b65cc6"
    Tmdb::Api.key(api_key)
  end

  def latest
    Tmdb::Movie.latest
  end

  def up_coming
    Tmdb::Movie.upcoming
  end

  def now_playing
    Tmdb::Movie.now_playing
  end

  def popular
    Tmdb::Movie.popular
  end

  def top_rated
    Tmdb::Movie.top_rated
  end

  def search_by_input(input)
    @search = Tmdb::Search.new
    @search.resource('movie')
    @search.query(input).fetch[0,5]
  end

  def set_movie(id)
    @movie = Tmdb::Movie.detail(id)
    @movie['trailers'] = self.movie_trailers(id)
    @movie['cast'] = self.movie_cast(id)
    @movie['similar_movies'] = self.movie_similar(id)
    @movie
  end

  def movie_trailers(id)
    trailers = Tmdb::Movie.trailers(id)
  end

  def movie_cast(id)
    cast = Tmdb::Movie.casts(id)
  end

  def movie_similar(id)
    similar_movies = Tmdb::Movie.similar_movies(id)
  end


end

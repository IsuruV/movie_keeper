class MovieSearcher
  attr_accessor :movie
  def initialize
    api_key = "e3245d0128a1ccf69e3fab0a65b65cc6"
    Tmdb::Api.key(api_key)
  end

  def self.find_movie_detail(id)
    self.new.set_movie(id)
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
    @search.query(input).fetch
  end

  def set_movie(id)
    @movie = Tmdb::Movie.detail(id)
    @movie['trailers'] = self.movie_trailers(id)
    @movie['cast'] = self.movie_cast(id)[0,5]
    @movie['similar_movies'] = self.movie_similar(id)[0,5]
    # @movie['watch_links'] = self.get_links(self.movie['original_title'])
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

  def get_links(title)
    MovieLinkScraper.new(title).links[0,5]
  end

end

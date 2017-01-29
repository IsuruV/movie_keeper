class MoviesController < ApplicationController
  before_filter :authenticate_user_from_token!, except: [:in_theaters, :highly_rated, :most_popular]

  def in_theaters
    @in_theaters = MovieSearcher.new
    respond_to do |format|
        format.json {render json: @in_theaters.now_playing.to_json}
    end
  end

  def highly_rated
    @highly_rated = MovieSearcher.new
    respond_to do |format|
        format.json {render json: @highly_rated.top_rated.to_json}
    end
  end

  def most_popular
    @most_popular = MovieSearcher.new
    respond_to do |format|
        format.json {render json: @most_popular.popular.to_json}
    end
  end

end

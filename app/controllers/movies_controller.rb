class MoviesController < ApplicationController
  before_filter :authenticate_user_from_token!, except: [:in_theaters, :highly_rated, :most_popular, :search, :show, :by_title]

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

  def search
    input = params[:search]
    @search = MovieSearcher.new
    respond_to do |format|
        format.json {render json: @search.search_by_input(input).to_json}
    end
  end

  def show
    id = params[:id].to_i
    @search = MovieSearcher.new
    respond_to do |format|
      format.json{render json: @search.set_movie(id).to_json}
    end
  end

  def by_title
    title = params[:title]
    @search = MovieSearcher.new
    respond_to do |format|
      format.json{render json: @search.get_links(title)}
    end
  end

end

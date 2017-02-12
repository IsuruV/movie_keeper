class MoviesController < ApplicationController
  def create
    user_id = params[:user_id]
    @user = User.find_by(:fb_id => user_id)
    @user.movies.find_or_create_by(movie_params)
    # respond_to do |format|
    #   format.json {render json: @user.movies.to_json}
    # end
    render json: @user.movies.to_json
  end

  def index
    @user = User.find_by(:fb_id => user_params)
    # respond_to do |format|
    #   format.json {render json: @user.movies.to_json}
    # end
    render json: @user.movies.to_json

  end

  def destroy
    @user = User.find_by(:fb_id=> user_params)
    @user.movies.where(movie_id: params[:movie_id]).delete
    # respond_to do |format|
    #   format.json{render json: @user.movies.to_json}
    # end
    render json:  @user.movies.to_json
  end

  def in_theaters
    @in_theaters = MovieSearcher.new
    # respond_to do |format|
    #     format.json {render json: @in_theaters.now_playing.to_json}
    # end
    render json: @in_theaters.now_playing.to_json
  end

  def highly_rated
    @highly_rated = MovieSearcher.new
    # respond_to do |format|
    #     format.json {render json: @highly_rated.top_rated.to_json}
    # end
    render json: @highly_rated.top_rated.to_json
  end

  def most_popular
    @most_popular = MovieSearcher.new
    # respond_to do |format|
    #     format.json {render json: @most_popular.popular.to_json}
    # end
    # render json: @most_popular.popular.to_json
    render json:{
      movies: @most_popular.popular.to_json
   }
  end

  def search
    input = params[:search]
    @search = MovieSearcher.new
    # respond_to do |format|
    #     format.json {render json: @search.search_by_input(input).to_json}
    # end
    render json: @search.search_by_input(input).to_json
  end

  def show
    id = params[:id].to_i
    @search = MovieSearcher.new
    # respond_to do |format|
    #   format.json{render json: @search.set_movie(id).to_json}
    # end
    render json: @search.set_movie(id).to_json
  end

  def by_title
    title = params[:title]
    @search = MovieSearcher.new
    # respond_to do |format|
    #   format.json{render json: @search.get_links(title)}
    # end
    render json: @search.get_links(title).to_json
  end

  private
  def movie_params
    params.require(:movie).permit(:movie_id, :title, :poster_path)
  end
  def user_params
    params.require(:user_id)
  end

end

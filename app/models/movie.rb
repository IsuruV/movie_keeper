class Movie
  include Mongoid::Document
  field :movie_id, type: String
  field :title, type: String
  field :poster_path, type: String
  embedded_in :user, :inverse_of => :movies
end

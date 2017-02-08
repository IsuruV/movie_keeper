Rails.application.routes.draw do

  get '/movies/in_theaters' => 'movies#in_theaters'
  get '/movies/highly_rated' => 'movies#highly_rated'
  get '/movies/most_popular' => 'movies#most_popular'
  get '/movies/title/:title' => 'movies#by_title'
  post'/movies/search' => 'movies#search'

  get '/movies/:id' => 'movies#show'

  resources :users
  resources :watchlists
  resources :comments
  devise_for :users, :controllers => {sessions: 'api/sessions', registrations: 'api/registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

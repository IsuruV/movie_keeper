Rails.application.routes.draw do
  resources :movies
  resources :watchlists
  resources :comments
  devise_for :users, :controllers => {sessions: 'api/sessions', registrations: 'api/registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

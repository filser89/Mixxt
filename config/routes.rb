Rails.application.routes.draw do
  devise_for :users
  root to: 'songs#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :songs, only: [:create]
  get 'global', to: 'songs#display_global'
  get 'favorites', to: 'songs#display_favorites'
  get 'history', to: 'songs#display_history'
end
# # get 'about', to: 'pages#about'
# /songs  post  songs create
# /global get songs display_global
# DEVICE  post
# /favorites  get songs display_favorites
# /history  get songs display_history

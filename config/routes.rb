Rails.application.routes.draw do
  devise_for :users
  root to: 'songs#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :songs, only: [:create]
  get 'fetch_msg', to: 'songs#fetch_msg'
  get 'global', to: 'songs#display_global'
  get 'favorites', to: 'songs#display_favorites'
  get 'history', to: 'songs#display_history'
  get 'share_from_btn', to: 'songs#share_from_btn'
  resources :users, only: [:edit, :update, :show]
  patch 'set_image', to: 'users#set_image'
  get 'songs_recognition', to: 'songs#songs_recognition'
  get 'get-user-token', to: 'users#get_token'
end
# # get 'about', to: 'pages#about'
# /songs  post  songs create
# /global get songs display_global
# DEVICE  post
# /favorites  get songs display_favorites
# /history  get songs display_history

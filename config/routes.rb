# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: 'welcome#index'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'

  resources :register, only: %i[new create], controller: 'users'

  resources :users, only: [:show] do
    resources :discover, only: [:index]

    resources :movies, only: %i[index show] do
      resources :viewing_party, only: %i[create new]
    end
  end
end

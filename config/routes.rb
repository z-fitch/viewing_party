Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: 'welcome#index'

  resources :register, only: [:index]

  resources :users, only: [:show, :new, :create] do 

    resources :discover, only: [:index]

    resources :movies, only: [:index, :show] do 
      resources :viewing_party, only: [:create, :new]
    end
  end
end
Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "posts#index"
  resources :posts do
    resources :replies

    member do
      post :favorite
      post :unfavorite
    end

    collection do
      get :feeds
    end
  end

  resources :users, only: [:edit, :update] do
    member do
      get :posts
      get :comments
      get :collects
      get :drafts
      get :friends
    end
  end

  resources :categories, only: [:show]
end

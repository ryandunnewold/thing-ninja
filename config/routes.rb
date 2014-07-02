Rails.application.routes.draw do
  devise_for :users
  
  root 'things#index'

  resources :things do
    collection do
      get :procrastinated
    end
    member do
      post :finish
      post :unfinish
      post :procrastinate
      post :unprocrastinate
    end
  end
end

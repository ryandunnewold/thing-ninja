Rails.application.routes.draw do
  devise_for :users
  
  root 'things#index'

  resources :things do
    member do
      post :finish
      post :unfinish
    end
  end
end

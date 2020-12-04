Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :cases do
    resources :rooms, only: [:edit, :update]
  end
  
  resources :users, only: [:show, :index, :update]

  root to: "cases#index"
end

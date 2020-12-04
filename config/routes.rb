Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :users, only: [:show]
  scope "/admin" do
    resources :users, only: [:index, :update]
  end
  
  resources :cases
  root to: "cases#index"
end

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope "/admin" do
    resources :users, only: [:index, :update]
  end

  devise_scope :user do
    root to: "devise/sessions#new"
    get '/users/sign_out' => 'devise/sessions#destroy'
    get '/users/:id' => 'users#show', as: :profile
  end
end

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  scope "/admin" do
    resources :users, only: [:index, :update]
  end

  devise_scope :user do
    root to: "devise/sessions#new"
  end
end

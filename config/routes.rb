Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :cases do
    member do
      delete :delete_video_attachment
    end
    member do
      patch :toogle_is_confirmed
    end
    member do
      post :generate_pdf
    end
  end
  
  devise_scope :user do
    authenticated :user do
      root 'cases#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :users, only: [:show, :index, :update]
end

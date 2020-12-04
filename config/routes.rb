Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :cases do
    resources :rooms, only: [:edit, :update]
    member do
      delete :delete_video_attachment
    end
  end
  
  resources :users, only: [:show, :index, :update]
  
  get '/cases/:id/pdf' => 'cases#show_pdf'
  root to: "cases#index"
end

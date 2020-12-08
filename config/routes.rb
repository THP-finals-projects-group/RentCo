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
  end
  
  resources :users, only: [:show, :index, :update]
  
  post '/cases/:id/pdf' => 'cases#generate_pdf', as: 'generate_pdf'
  post '/cases/:id/compute' => 'cases#generate_compute', as: 'generate_compute'


  root to: "cases#index"
end

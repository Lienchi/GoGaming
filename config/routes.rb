Rails.application.routes.draw do
  #devise_for :users, :controllers => { registrations: 'registrations' }
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "gostations#index"
  
  resources :users, only: [:show, :index, :edit, :update] do
    collection do
      get :leaderboards
      get :f_leaderboards
    end
  end
   
  resources :gostations, only:[:index] do
    member do
      post :checkin
      post :uncheckin
      post :getCheckinStatus
    end
    collection do
      post :getCurrentUserPoints
      post :getCurrentUserExp
    end
  end

  resources :challenges, only:[:create] do
    member do
      post :setDisplayModalStatus
    end
  end


  resources :trip_gostations, only:[:show] do 
    member do 
      post :check
      post :getCheckinStatus
    end
  end 
  

  resources :trips, only: [:index, :show]

  resources :trips, only: [:show] do
    resources :comments, only: [:index, :create]
  end
   

  namespace :admin do
    root "gostations#index"
    resources :gostations
    resources :trips
  end
   
  resources :followships, only:[:create, :destroy]

  resources :products, only:[:index]
  resources :user_products, only:[:create]

end

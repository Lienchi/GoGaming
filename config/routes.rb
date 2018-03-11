Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations' }
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "paths#index" 
  resources :users, only: [:show]


  namespace :admin do
    root "paths#index"
  end

end

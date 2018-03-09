Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "paths#index" 


  namespace :admin do
    root "paths#index"
  end

end

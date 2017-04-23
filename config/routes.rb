Rails.application.routes.draw do
  get 'welcome/index'

  root "welcome#index"
 
  resources :users, :projects, :timelogs
  resources :api do 
  	collection do
  		resources :timelogs
  	end
  end

  post 'users/login', :to => 'users#login'
  post 'users/logout', :to => 'users#logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

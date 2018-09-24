Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "application#index"
   get '/UserHome', to: 'application#index'
   get '/GetLoggedUserInfo', to: 'application#GetLoggedUserInfo'
   get '/login', to: 'application#index'
   get '/register', to: 'application#index'
end

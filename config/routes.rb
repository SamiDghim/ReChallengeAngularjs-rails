Rails.application.routes.draw do

  namespace 'conge' do
      resources :conge
      post '/saveConge', to: 'conge#create'
      get '/GetUserConges/(/:id)', to: 'conge#getUserConges'
      get '/getUserCongeModel/(/:id)', to: 'conge#getUserCongeModel'
      get '/GetAllUsers', to: 'conge#GetAllUsers'
      get '/GetAllDemandsNonT', to: 'conge#GetAllDemandesNonT'
      get '/GetAllDemandsT', to: 'conge#GetAllDemandsT'
      get '/search/(/:motCle)', to: 'conge#searchDemandesNonT'
      post '/RejectConge/(/:id)', to: 'conge#RejectConge'
      post '/AcceptConge/(/:id)', to: 'conge#AcceptConge'
  end


  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "application#index"
   get '/UserHome', to: 'application#index'
   get '/AdminHome', to: 'application#index'
   get '/GetLoggedUserInfo', to: 'application#GetLoggedUserInfo'
   get '/login', to: 'application#index'
   get '/register', to: 'application#index'
end

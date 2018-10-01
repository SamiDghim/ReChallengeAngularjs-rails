Rails.application.routes.draw do
  devise_for :users

  namespace 'conge' do
      resources :conge
      post '/saveConge', to: 'conge#create'
      get '/GetUserConges/(/:id)', to: 'conge#getUserConges'
      get '/getUserCongeModel/(/:id)', to: 'conge#getUserCongeModel'
      get '/GetAllDemandsNonT/(/:p)', to: 'conge#GetAllDemandesNonT'
      get '/GetAllDemandsT/(/:p)', to: 'conge#GetAllDemandsT'
      get '/search/(/:motCle)', to: 'conge#searchDemandesNonT'
      post '/RejectConge/(/:id)', to: 'conge#RejectConge'
      post '/AcceptConge/(/:id)', to: 'conge#AcceptConge'
  end

  root "application#index"
   get '/UserHome', to: 'application#index'
   get '/AdminHome', to: 'application#index'
   get '/GetLoggedUserInfo', to: 'application#GetLoggedUserInfo'
   get '/login', to: 'application#index'
   get '/register', to: 'application#index'
   get '/GetAllUsers/(/:p)', to: 'user#GetAllUsers'
end

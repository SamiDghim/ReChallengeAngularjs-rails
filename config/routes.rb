Rails.application.routes.draw do
  devise_for :users

  namespace 'conge' do
      resources :conge
      post '/saveConge', to: 'conge#create'
      get '/GetUserConges/(/:id)', to: 'conge#getUserConges'
      get '/getUserCongeModel/(/:id)', to: 'conge#getUserCongeModel'
      get '/GetAllDemandsNonT/(/:p)', to: 'conge#GetAllDemandesNonT'
      get '/GetAllDemandsT/(/:p)', to: 'conge#GetAllDemandsT'
      get '/search/(/:motCle)/(/:p)', to: 'conge#searchDemandesNonT'
      post '/RejectConge/(/:id)', to: 'conge#RejectConge'
      post '/AcceptConge/(/:id)', to: 'conge#AcceptConge'
      delete '/deleteDemande/(/:id)', to: 'conge#deleteDemande'
      put '/updateDemande/:id', to: 'conge#updateDemande'
      get '/GetDemands/(/:p)', to: 'conge#GetAllConges'

  end

  root "application#index"
   get '/UserHome', to: 'application#index'
   get '/profil', to: 'application#index'
   get '/state', to: 'application#index'
   get '/AdminHome', to: 'application#index'
   get '/GetLoggedUserInfo', to: 'application#GetLoggedUserInfo'
   get '/login', to: 'application#index'
   get '/register', to: 'application#index'
   get '/GetAllUsers/(/:p)', to: 'user#GetAllUsers'
   put '/updateUser/(/:id)', to: 'user#updateUser'
   put '/profil/(/:id)', to: 'user#changeInfo'
#   match '*a', :to => 'application#not_found', via: :get

end

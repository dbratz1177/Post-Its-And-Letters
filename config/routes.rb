LaunchU::Application.routes.draw do
  
  root "pages#sitehome"

  get 'userpage/:username', to: "userpage#home"
  get 'userpage', to: "userpage#home"

  #This route connects a noteboard to a userpage
  mount Noteboard::Engine, at: '/userpage/:username(.:format)'
  #Most of the routes that have GET can be ignored eventually
  #since the forms will be made in the backbone app but the
  #Ones that post are here to stay. 
=begin
  GET /userpage/:username/notes             notes#index
  GET /userpage/:username/notes/new         notes#new
  POST /userpage/:username/notes/create     notes#create
  GET /userpage/:username/notes/:id         notes#show
  GET /userpage/:username/notes/:id/edit    notes#edit
  PATCH/PUT /userpage/:username/notes/:id   notes#update
  DELETE /userpage/:username/notes/:id      notes#destroy
=end 

  #get "home", to: "pages#home", as: "home"
  #This needs to be here for default user editing
  get "inside", to: "pages#inside", as: "inside"

  devise_for :users

  namespace :admin do
    root "base#index"
    resources :users
  end 
end

LaunchU::Application.routes.draw do
  
  #Since the root of the engine is set, this needs to be above
  #all engines or else it'll match the engine first
  root "pages#sitehome"
  get 'userpage/:username', to: "userpage#home", as: "home"
  get 'userpage', to: "userpage#home"

  mount Noteboard::Engine, at: '/'
  #get "home", to: "pages#home", as: "home"
  #This needs to be here for default user editing
  get "inside", to: "pages#inside", as: "inside"
  
  devise_for :users
  namespace :admin do
    root "base#index"
    resources :users
  end 
  
end

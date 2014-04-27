LaunchU::Application.routes.draw do
  root "pages#sitehome"

  get 'userpage/:username', to: "userpage#home"
  get 'userpage', to: "userpage#home"

  #get "home", to: "pages#home", as: "home"
  #This needs to be here for default user editing
  get "inside", to: "pages#inside", as: "inside"

  devise_for :users

  namespace :admin do
    root "base#index"
    resources :users
  end 
end

LaunchU::Application.routes.draw do
  root "pages#sitehome"

  get 'userpage/:username', to: "userpage#home"
  get 'userpage', to: "userpage#home"

  mount Noteboard::Engine, at: '/userpage/:username(.:format)'

  #Decided to explicitly write these routes out instead of using resources for the time being
  #Return an HTML form for creating the notes
  #get 'userpage/:username/note/new'
  #Create the new note
  #post 'userpage/:username/
  #GET /geocoder/new 	geocoders#new 	return an HTML form for creating the geocoder
  #POST /geocoder 	geocoders#create 	create the new geocoder
  #GET /geocoder 	geocoders#show 	display the one and only geocoder resource
  #GET/geocoder/edit 	geocoders#edit 	return an HTML form for editing the geocoder
  #PATCH/PUT /geocoder 	geocoders#update 	update the one and only geocoder resource
  #DELETE /geocoder 	geocoders#destroy 	delete the geocoder resource 

  #I could just mount the engine as a resource at the end of the userpage






  #get "home", to: "pages#home", as: "home"
  #This needs to be here for default user editing
  get "inside", to: "pages#inside", as: "inside"

  devise_for :users

  namespace :admin do
    root "base#index"
    resources :users
  end 
end

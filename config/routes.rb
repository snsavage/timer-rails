Rails.application.routes.draw do
  resources :groups
  resources :routines
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'register', to: 'users#create'
      post 'signin', to: 'auth#create'
    end
  end
end

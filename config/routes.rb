Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :routines, only: [:index, :show, :create, :update, :destroy]
      post 'register', to: 'users#create'
      post 'signin', to: 'auth#create'
    end
  end
end

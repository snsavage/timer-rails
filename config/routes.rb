Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'register', to: 'users#register'
      post 'signin', to: 'users#sign_in'
    end
  end
end

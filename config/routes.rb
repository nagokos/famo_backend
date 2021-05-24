Rails.application.routes.draw do
  root to: 'home#index'

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create] do
        get :active, on: :member
        collection do
          scope module: :users do
            resource :current, only: %i[show update]
          end
        end
      end
      post '/login', to: 'user_sessions#create'
      delete '/logout', to: 'user_sessions#destroy'
    end
  end

  get '*path', to: 'home#index'
end

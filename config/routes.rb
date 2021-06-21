Rails.application.routes.draw do
  root to: 'home#index'

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create] do
        collection do
          scope module: :users do
            resource :current, only: %i[show update]
          end
        end
      end
      resource :profiles, only: %i[create update]
      resources :leagues, only: %i[index]
      resources :prefecture_teams, only: %i[index]
      resources :teams, only: %i[create]
      resources :account_activations, only: %i[create edit]
      post '/login', to: 'user_sessions#create'
      delete '/logout', to: 'user_sessions#destroy'
    end
  end

  get '*path', to: 'home#index'
end

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
      resources :leagues, only: %i[index]
      resources :categories, only: %i[index]
      resources :groups, only: %i[index]
      resources :prefectures, only: %i[index]
      resources :teams, only: %i[index create]
      resources :account_activations, only: %i[create edit]
      post '/login', to: 'user_sessions#create'
      delete '/logout', to: 'user_sessions#destroy'
    end
  end

  get '*path', to: 'home#index'
end

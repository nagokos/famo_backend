Rails.application.routes.draw do
  root to: 'home#index'
  get 'account/password_reset', to: 'home#index'
  get 'account/send_password_reset', to: 'home#index'

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create show] do
        collection do
          scope module: :users do
            resource :current, only: %i[show update destroy] do
              scope module: :current do
                resources :followers, only: %i[index]
                resources :following, only: %i[index]
                resources :reviews, only: %i[index update destroy]
                resource :profile, only: %i[create update destroy]
                resource :password_changes, only: %i[update]
              end
            end
          end
        end
        scope module: :users do
          resources :reviews, only: %i[index create]
          resources :followers, only: %i[index]
          resources :following, only: %i[index]
          resource :relationships, only: %i[create destroy] do
            get :check, on: :member
          end
        end
      end
      resources :players, only: %i[index]
      resources :password_resets, only: %i[create edit update]
      resources :reviews, only: %i[index]
      resources :leagues, only: %i[index show] do
        resources :categories, only: %i[index]
        scope module: :leagues do
          resources :teams, only: %i[index]
        end
      end
      resources :categories, only: %i[show] do
        resources :groups, only: %i[index]
        scope module: :categories do
          resources :teams, only: %i[index]
        end
      end
      resources :groups, only: %i[show] do
        scope module: :groups do
          resources :teams, only: %i[index]
        end
      end
      resources :hierarchy_leagues, only: %i[index]
      resources :prefecture_teams, only: %i[index]
      resources :teams, only: %i[create]
      resources :account_activations, only: %i[create edit]
      post '/login', to: 'user_sessions#create'
      delete '/logout', to: 'user_sessions#destroy'
    end
  end

  get '*path', to: 'home#index'
end

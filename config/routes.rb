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
      resources :password_resets, only: %i[create edit update]
      resources :reviews, only: %i[index]
      resources :leagues, only: %i[index show] do
        scope module: :leagues do
          resources :users, only: %i[index]
          resources :teams, only: %i[index]
        end
      end
      resources :categories, only: %i[index] do
        scope module: :categories do
          resources :users, only: %i[index]
          resources :teams, only: %i[index]
        end
      end
      resources :groups, only: %i[index] do
        scope module: :groups do
          resources :users, only: %i[index]
          resources :teams, only: %i[index]
        end
      end
      resources :hierarchy_leagues, only: %i[index]
      resources :prefecture_teams, only: %i[index]
      resources :teams, only: %i[create]
      resources :account_activations, only: %i[create edit]
      get ':league_id/categories/:id', to: 'categories#show'
      get ':league_id/:category_id/groups/:id', to: 'groups#show'
      get ':league_id/:category_id/:group_id/users/:id', to: 'groups/users#show'
      post '/login', to: 'user_sessions#create'
      delete '/logout', to: 'user_sessions#destroy'
    end
  end

  get '*path', to: 'home#index'
end

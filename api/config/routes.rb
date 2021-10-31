Rails.application.routes.draw do
  namespace :admin do
    root to: 'users#index'
    resources :profiles
    resources :reviews
    resources :leagues
    resources :categories
    resources :groups
    resources :prefectures
    resources :teams
    resources :authentications
    resources :relationships
    resources :users
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create] do
        collection do
          scope module: :users do
            resource :current, only: %i[show update destroy] do
              post :presigned_post
              scope module: :current do
                resources :followers, only: %i[index]
                resources :following, only: %i[index]
                resources :reviews, only: %i[index update destroy]
                resources :game_dates, only: %i[index]
                resources :rating_averages, only: %i[index]
                resources :notifications, only: %i[index update] do
                  get :check, on: :collection
                end
                resource :profile, only: %i[create update destroy]
                resource :password_change, only: %i[update]
              end
            end
          end
        end
        resource :relationships, only: %i[create destroy] do
          get :check
        end
        scope module: :users do
          resources :reviews, only: %i[index create]
          resources :followers, only: %i[index]
          resources :following, only: %i[index]
          resources :game_dates, only: %i[index]
          resources :rating_averages, only: %i[index]
        end
      end
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
      resources :players, only: %i[index show]
      resources :reviewers, only: %i[show]
      resources :password_resets, only: %i[create edit update]
      resources :reviews, only: %i[index] do
        resource :like, only: %i[create destroy] do
          get :check
          get :count
        end
      end
      resources :top_players, only: %i[index]
      resources :hierarchy_leagues, only: %i[index]
      resources :prefecture_teams, only: %i[index]
      resources :teams, only: %i[index create]
      resources :account_activations, only: %i[create edit]
      post '/login', to: 'user_sessions#create'
      delete '/logout', to: 'user_sessions#destroy'
      post 'oauth/callback', to: 'oauths#callback'
      get 'oauth/callback', to: 'oauths#callback'
      get 'oauth/:provider', to: 'oauths#oauth'
    end
  end
end

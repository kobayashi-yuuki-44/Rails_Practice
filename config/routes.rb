Rails.application.routes.draw do
  root 'static_pages#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create]
  resources :boards , shallow: true do
    resources :comments, only: %i[create destroy],
    collection do
      get :bookmarks
    end
  end
  resources :bookmarks, only: %i[create destroy]

  resource :profile, only: %i[show edit update]
  namespace :admin do
    root to: 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :boards, only: %i[index edit update show destroy]
    resources :users, only: %i[index edit update show destroy]
  end
end

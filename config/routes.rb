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
end

end

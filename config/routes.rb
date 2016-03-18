Rails.application.routes.draw do
  root to: 'rooms#show'
  get 'login', to: 'users#login', as: :login
  # get 'rooms', to: 'rooms#show', as: :rooms

  # root to: 'users#login'
  # get 'rooms', to: 'rooms#show', as: :rooms

  resources :rooms do
    member do
      get :start_chat
    end
  end
  resources :users do
    collection do
      post :login
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end

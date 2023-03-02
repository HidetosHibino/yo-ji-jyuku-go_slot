Rails.application.routes.draw do
  get 'slot_yojis/index'
  get 'slot_yojis/new'
  get 'slot_yojis/destroy'
  root 'static_pages#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create]
  resources :basic_yojis, only: %i[index new create show edit update destroy] do
    resources :samples, only: %i[create update destroy], module: :basic_yojis
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :kanjis, only: %i[index show]
  resources :slot_yojis, only: %i[index new show create edit update destroy] do
    resources :samples, only: %i[create update destroy], module: :slot_yojis
    collection do
      post :confirm
    end
  end
end

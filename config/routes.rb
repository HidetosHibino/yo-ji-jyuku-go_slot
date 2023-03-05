Rails.application.routes.draw do
  root 'static_pages#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create]
  resources :basic_yojis, only: %i[index new create show edit update destroy] do
    resources :samples, only: %i[create update destroy], module: :basic_yojis
  end
  resources :kanjis, only: %i[index show]
  resources :slot_yojis, only: %i[index new show create edit update destroy] do
    collection do
      post :confirm
    end
    resources :samples, only: %i[create update destroy], module: :slot_yojis
    resources :meanings, only: %i[create update destroy], module: :slot_yojis, controller: :user_reactions, defaults: { type: 'Meaning' }
    resources :comments, only: %i[create update destroy], module: :slot_yojis, controller: :user_reactions, type: 'Comment'
  end
  resources :bookmarks, only: %i[index create destroy]
end

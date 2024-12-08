Rails.application.routes.draw do
  devise_for :users
  root to: 'prototypes#index'

  resources :prototypes do
    resources :comments, only: [:create] # コメント投稿機能を追加
  end

  resources :users, only: [:show] # usersリソースを独立して設定
end
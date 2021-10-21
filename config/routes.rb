Rails.application.routes.draw do

  root 'homes#home'
  
  #「 devise_for :users」
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions:      'users/sessions'
  }
  
  devise_scope :user do
    get 'users/index'  , to: 'users/registrations#index'
    get 'users/destroy', to: 'users/sessions#destroy'
  end 
  
  namespace :admin do
    resources :users, only: [:index, :create, :destroy]
  end
 
  resources :users, only: [:show], shallow: true do
    resources :stocks   , only: [:index, :create, :destroy]
    resources :followees, only: [:index, :create, :destroy]
    resources :followers, only: [:index]
  end
  
  resources :posts do
    resources :comments, only: [:create, :destroy], module: :posts
    resources :likes   , only: [:create, :destroy], module: :posts
  end
  
  resources :questions, shallow: true do
    resources :comments, only: [:create, :destroy], module: :questions
    resources :likes   , only: [:create, :destroy], module: :questions
    resources :answers , only: [:create, :destroy, :edit, :update] do
      resources :comments, only: [:create, :destroy], module: :answers
      resources :likes   , only: [:create, :destroy], module: :answers
    end
  end
  
  namespace :category, shallow: true do
    resources :categories, only: [:index, :show]
  end
  
  # ユーザーがカテゴリーをフォローする時のルーティング。delete時、relationshipのidを取らない形にするため手動のルーティングに。
  post   '/follow_category'  , to: "follow_categories#create"
  delete '/unfollow_category', to: "follow_categories#destroy"

  resources :searches     , only: :index

  resources :notifications, only: :index

  resources :rankings     , only: :index
  
end

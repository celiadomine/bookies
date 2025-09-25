Rails.application.routes.draw do

  # Root route
  root 'home#index'

  # Search route with a named helper
  get 'search', to: 'search#index', as: 'books_search'

  # User authentication routes
  get 'signup', to: 'registrations#new'
  post 'signup', to: 'registrations#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  post 'logout', to: 'sessions#destroy'

  # Password reset routes
  resources :passwords, only: [:new, :create, :edit, :update]

  # Profile routes
  resources :profiles, only: [:show, :edit, :update] do
    member do
      get :confirm_email
    end
  end

  # Nested and standard resource routes for Books, Reviews, and Posts
  resources :books, only: [:index, :show, :destroy] do
    resources :reviews, only: [:new, :create] do
      resources :likes, only: [:create, :destroy] 
    end
    resources :posts, only: [:new, :create, :destroy] do
      resources :likes, only: [:create, :destroy] 
    end
  end

  # Admin namespace
  namespace :admin do
    resources :users, only: [:index, :edit, :update]
  end
end
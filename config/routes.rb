Rails.application.routes.draw do
  # Search route for books
  get "books/search", to: "books#search"  # You might need this route for book search.

  # Password reset routes
  resources :passwords, only: [:new, :create, :edit, :update]

  # Reviews routes (nested within books)
  resources :books do
    resources :reviews, only: [:create]  # Reviews are created within the context of a specific book
  end

  # User authentication routes
  get "signup", to: "registrations#new"
  post "signup", to: "registrations#create"
  post "registrations", to: "registrations#create" 
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"

  # The :delete method is still the RESTful convention
  delete "logout", to: "sessions#destroy"

  # Add a post route to handle form submissions
  post "logout", to: "sessions#destroy"

  # Profile routes
  resources :profiles, only: [:show, :edit, :update] do
    member do
      get :confirm_email
    end
  end

  # Root route
  root 'home#index'  # The homepage route
end

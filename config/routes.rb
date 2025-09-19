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
  delete "logout", to: "sessions#destroy"

  # Profile routes
  get "profiles/show", to: "profiles#show"
  get "profiles/edit", to: "profiles#edit"
  patch "profiles/update", to: "profiles#update"

  # Root route
  root 'home#index'  # The homepage route
end

Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations",
    omniauth_callbacks: "users/omniauth_callbacks"}
  resources :reviews, only: :index
  resources :users, only: [:index, :show, :edit, :update]
  resources :books do
    resources :reviews, except: :index
    member do
      patch :accept_request, :reject_request
      put :accept_request, :reject_request
    end
  end
  resources :categories
  resources :search, only: :index
  resources :book_requests, only: :index
  root "static_pages#home"
end

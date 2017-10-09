Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations",
    omniauth_callbacks: "users/omniauth_callbacks"}
  resources :reviews, only: :index
  resources :users, only: :show
  resources :books do
    resources :reviews, except: :index
  end
  resources :categories
  root "static_pages#home"
end

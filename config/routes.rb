Rails.application.routes.draw do
  resources :reviews, only: :index
  resources :books do
    resources :reviews, except: :index
  end
  resources :categories
  root "static_pages#home"

  devise_for :users, controllers: {registrations: "registrations",
    omniauth_callbacks: "users/omniauth_callbacks"}
end

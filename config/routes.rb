Rails.application.routes.draw do
  resources :books
  resources :categories
  root "static_pages#home"

  devise_for :users, controllers: {registrations: "registrations",
    omniauth_callbacks: "users/omniauth_callbacks"}
end

Rails.application.routes.draw do
  resources :categories
  root "static_pages#home"

  devise_for :users, controllers: {registrations: "registrations"}
end

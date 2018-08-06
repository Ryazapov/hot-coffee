Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  root to: "pages#index"

  resources :coffee_houses, only: %i[index show]
  resources :coffees, only: %i[index show]

  namespace :manage do
    resources :coffee_houses do
      resources :coffees, only: %i[new create show edit update destroy]
    end
  end
end

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  root to: "pages#home"

  resources :coffee_houses, only: %i[index show] do
    resources :coffees, only: %i[show]
  end

  namespace :manage do
    resources :coffee_houses do
      resources :coffees, only: %i[new create show edit update destroy]
    end
  end
end

Rails.application.routes.draw do
  devise_for :users
  root to: "toppages#index"
  resources :genres , only: [:new, :create]
  resources :books , only: [:index, :new, :create, :edit, :update, :destroy]
end

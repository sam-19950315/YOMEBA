Rails.application.routes.draw do
  devise_for :users
  root to: "toppages#index"

  
  resources :books , only: [:index, :new, :create, :edit, :update, :destroy]
end

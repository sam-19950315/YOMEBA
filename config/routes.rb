Rails.application.routes.draw do
  root to: "toppages#index"
  resources :books , only: [:index]
end

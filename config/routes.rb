Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'users/registrations' }
  root to: "toppages#index"
  resources :books , only: [:index, :create, :new, :destroy]
  resources :genres , only: [:new, :create] 

  post 'read_book_log/:id' => 'read_book_logs#create', as: 'create_read_book_log'
  get 'read_book_log' => 'read_book_logs#book_ranking', as: 'index_book_ranking'
end

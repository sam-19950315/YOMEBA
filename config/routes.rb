Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'users/registrations' }
  root to: "toppages#index"
  resources :books , only: [:index, :create, :new, :destroy]
  resources :genres , only: [:new, :create] 
  resources :trashes , only: [:index]

  post 'read_book_log/:id' => 'read_book_logs#create', as: 'create_read_book_log'
  get 'read_book_log' => 'read_book_logs#book_ranking', as: 'index_book_ranking'
  post 'books/:id' => 'books#trash', as: 'trash_book'
  post 'trashes/:id' => 'trashes#reverse', as: 'trash_reverse'
end

Rails.application.routes.draw do
  get 'bookings/index'
  root to: 'events#index'
  devise_for :users
  resources :events do 
    resources :bookings, only: [:create]
  end
  get 'my_events', to: 'events#current_user_events'
  get 'my_bookings', to: 'bookings#index'
  
end

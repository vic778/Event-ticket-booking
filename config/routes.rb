Rails.application.routes.draw do
  root to: 'events#index'
  devise_for :users
  resources :events
  get 'my_events', to: 'events#current_user_events'
  
end

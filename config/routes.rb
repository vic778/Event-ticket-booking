Rails.application.routes.draw do
  get 'events/index'
  root to: 'events#index'
  devise_for :users
end

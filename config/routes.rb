Rails.application.routes.draw do
  resources :users, except: [:destroy]
  resources :questions
  root to: 'users#index'
end

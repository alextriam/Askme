Rails.application.routes.draw do
  resources :questions, except: [:show, :new, :index]

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, except: [:destroy]
  resources :questions
  root to: 'users#index'
  get 'sign_up' => 'users#new'
  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'
end

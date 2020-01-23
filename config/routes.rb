Rails.application.routes.draw do
  root to: 'divisions#index'
  devise_for :users
  resources :divisions do
    resources :employees
  end
  # resources :employees do
    resources :projects do
      member do
        post :add
        post :remove
      end
    end
    resources :employees do
      member do
        post :add
        post :remove
      end
    end
  end
  # resources :projects do
  #   resources :employees
  # end
# end

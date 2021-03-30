Rails.application.routes.draw do
  devise_for :users
  
  root 'home#index'

  resources :promotions do
    get 'search', on: :collection
  end

  resources :coupons, only: %i[create] do
    post 'disable', on: :member
  end

  resources :categories
end
Rails.application.routes.draw do
  devise_for :users
  
  root 'home#index'

  resources :promotions do
    get 'search', on: :collection
    post 'approve', on: :member
  end

  resources :coupons, only: %i[create] do
    post 'disable', on: :member
  end

  resources :categories
end
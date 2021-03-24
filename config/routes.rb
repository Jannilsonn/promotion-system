Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :promotions, only: %i[index show new create edit update destroy]

  resources :coupons, only: %i[create] do
    post 'disable', on: :member
  end

  resources :categories, only: %i[index show new create edit update destroy]
end
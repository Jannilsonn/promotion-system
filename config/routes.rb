Rails.application.routes.draw do
  devise_for :users
  
  root 'home#index'

  resources :promotions do
    get 'search', on: :collection
    post 'approve', on: :member
  end

  resources :coupons, only: %i[create] do
    member do
      post 'disable'
      post 'enable'
    end
  end

  resources :categories

  namespace :api do
    namespace :v1 do
      resources :coupons, only: %i[show], param: :code
    end
  end

end
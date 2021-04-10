Rails.application.routes.draw do
  devise_for :users
  
  root 'home#index'

  resources :promotions do
    get 'search', on: :collection
    post 'approve', on: :member
  end

  resources :coupons, only: %i[index show create] do
    get 'search', on: :collection
    member do
      post 'disable'
      post 'enable'
    end
  end

  resources :categories

  namespace :api, constraints: ->(req) { req.format == :json } do
    namespace :v1 do
      resources :coupons, only: %i[show], param: :code
      resources :promotions, only: %i[show create update]
    end
  end

end
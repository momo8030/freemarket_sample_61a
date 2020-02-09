Rails.application.routes.draw do

  devise_for :users
  root to: 'items#index'
  resources :items, only: :index
  resources :users, only: [:show, :new] do
    get :profile_edit
  end
  
  resources :signups, only: [:new, :create] do
    collection do
      get 'user1'
      get 'user2'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

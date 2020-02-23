Rails.application.routes.draw do

  devise_for :users, controllers: {
  omniauth_callbacks: 'users/omniauth_callbacks',
  registrations: 'users/registrations'
  }
  root 'items#index'
  resources :items, only: [:index, :new] do
    get :confirmation
  end

  resources :users, only: [:show, :new] do
    get :profile_edit
    get :identification
    get :logout
  end
  
  resources :signups, only: [:new, :create] do
    collection do
      get 'phone_number'
      post 'done'
    end
  end

  resources :cards,only:[:new, :create,:show]do
   
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

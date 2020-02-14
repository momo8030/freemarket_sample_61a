Rails.application.routes.draw do

  devise_for :users, controllers: {
  omniauth_callbacks: 'users/omniauth_callbacks',
  registrations: 'users/registrations'
  }
  root to: 'items#index'
  resources :items, only: :index

  resources :users, only: [:show, :new] do
    get :profile_edit
    get :identification
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do

  devise_for :users, controllers: {
  omniauth_callbacks: 'users/omniauth_callbacks',
  registrations: 'users/registrations'
  }
  
  root 'items#index'
  resources :items, only: [:index, :new, :show] do
    get :confirmation
  end

  resources :users, only: [:show, :new] do
    get :profile_edit
    get :identification
    get :logout
  end
  
  resources :signups, only: [:index] do
    collection do
      get 'step1' #情報の一部を入力
      post 'step1', to: 'signups#step1_validates' #入力した情報のバリデーションチェック
      get 'step2' #残りの情報を入力
      post 'step2',to: 'signups#create' #入力した情報を保存
      get 'done'
    end
  end

  resources :cards,only:[:new, :create,:show]do
   
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

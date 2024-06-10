Rails.application.routes.draw do
 
  devise_for :admin, skip: [:registrations], controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    get '/' => 'homes#top'
    get 'dashboards', to: 'dashboards#index'
    resources :areas, only: [:index, :create, :edit, :update, :destroy]
    resources :temperatures, only: [:index, :create, :edit, :update, :destroy]
  end
  
  devise_for :user, controllers:{
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }
  
  devise_scope :user do
    post 'user/gest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  
  resources :posts do
    resource :favorite, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    collection do
      get :search
    end
  end
  
  resources :users, only: [:show, :edit, :update] do
    member do
      get :favorites
    end
  end
  
  get '/users/check' => 'usres#check'
  patch '/users/withdraw' => 'usres#withdraw'
  
  root to: "homes#top"
  get "about" => "homes#about"
    

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

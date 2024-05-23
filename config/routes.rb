Rails.application.routes.draw do
 
  devise_for :admins, controllers: {
    registrations: 'admin/registrations',
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    resources :areas, only: [:index, :create, :edit, :update, :destroy]
    resources :temperatures, only: [:index, :create, :edit, :update, :destroy]
  end

  namespace :public do
    
  end  
  
  devise_for :users
  
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
  resources :users, only: [:show, :edit, :update]
  
  
  root to: "homes#top"
  get "about" => "homes#about"
    

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

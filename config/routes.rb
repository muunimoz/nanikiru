Rails.application.routes.draw do
  root to: "homes#top"
  get "about" => "homes#about"
  devise_for :admin, skip: [:registrations], controllers: {
    sessions: 'admin/sessions'
  }
  devise_for :user, controllers:{
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }
  devise_scope :user do
    post 'user/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  namespace :admin do
    get '/' => 'homes#top'
    resources :users, only: [:index, :edit, :update ]
    resources :posts, only: [:index, :edit, :update, :destroy]
    resources :comments, only: [:index, :edit, :update, :destroy]
    resources :areas, only: [:index, :create, :edit, :update, :destroy]
    resources :temperatures, only: [:index, :create, :edit, :update, :destroy]
  end
  scope module: :public do
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
    get '/users/check' => 'users#check'
    patch '/users/withdraw' => 'users#withdraw'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end














Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  
  root to: "homes#top"
   get "about" => "homes#about"
   
  devise_scope :user do
     post 'user/gest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  
 
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

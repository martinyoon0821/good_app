Rails.application.routes.draw do
  get 'home/mypage'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root "boards#index"
  
  get 'boards/index'
  get 'boards/show/:id' => "boards#show"
  get 'boards/new'
  post 'boards/create'
  get 'boards/edit/:id' => "boards#edit"
  post 'boards/update/:id' => "boards#update"
  get 'boards/destroy/:id' => "boards#destroy"
  
  post 'boards/:board_id/comments' => "comments#create"
  get 'comments/destroy/:id' => "comments#destroy"
  
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  
  get 'boards/map'
  post 'boards/marker'
  get 'boards/index' => 'boards#index'
  get 'boards/likes/:board_id' => "likes#create"
  get "home/mypage" => "home#mypage"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :home, only: [:index]
  resources :users, only: [:index, :edit, :update, :new, :create, :show]
  resources :chats, controller: 'chats'
  resources :messages, controller: 'messages'
end
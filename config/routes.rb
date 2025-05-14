Rails.application.routes.draw do
  resources :users, only: [:index, :edit, :update, :new, :create, :show]
  resources :chats, controller: 'chats'
  resources :messages, controller: 'messages'
end
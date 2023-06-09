Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :festivals, only: %i[index show] do
    resources :favorites, only: [:create]
    resources :artists, only: [:show]
  end

  resources :favorites, only: [:destroy]

  resources :chatrooms, only: %i[index show] do
    resources :messages, only: :create
  end

end

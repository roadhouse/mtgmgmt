Magic::Application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "social_login"}
  mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)

  root to: "decks#index"

  resources :cards
  resources :users do
    resources :lists, only: [:show], constraints: {id: /[a-z][A-z]+/}, param: :name
  end

  resources :decks do
    get :print, :cockatrice,  on: :member
    get :search, on: :collection
  end

  resources :inventories do
    get :have, on: :collection
    get :want, on: :collection
  end

  resource :searches do
    get :top_cards
  end
end

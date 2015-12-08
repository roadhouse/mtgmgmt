Magic::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  root :to => "decks#index"

  resources :cards
  resources :collections, only: [:create, :update]

  resources :decks do
    get :print, on: :member
    get :search, on: :collection
  end

  resources :inventories do
    get :have, on: :collection
    get :want, on: :collection
  end
end

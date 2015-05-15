Magic::Application.routes.draw do
  root :to => "decks#index"

  resources :card_decks, :only => [:create, :destroy, :update]
  resources :decks do
    get :search, on: :collection
    get :print, on: :member
  end
  resources :cards
  resources :inventories
end

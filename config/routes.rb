Magic::Application.routes.draw do
  root :to => "decks#index"

  resources :searches, :only => [:index, :create]
  resources :card_decks, :only => [:create, :destroy, :update]
  resources :decks
  resources :cards
  resources :inventories
end

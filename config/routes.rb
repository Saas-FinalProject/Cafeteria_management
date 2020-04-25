Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :menus
  resources :menu_items
  resources :orders
  resources :order_items
  resources :users

  get "/" => "home#index"

  get "/signin/new" => "sessions#new", as: :new_session
  post "/signin" => "sessions#create", as: :sessions
  delete "/signout" => "sessions#destroy"

  post "/menus/UpdateActiveMenu" => "menus#updateActiveMenu"

  post "/users/:id/removeAsClerk" => "users#removeAsClerk"
  post "/users/:id/makeAsClerk" => "users#makeAsClerk"
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/menus/changemenu" => "menus#changeMenu", as: :change_menus
  resources :menus
  resources :menu_items
  resources :order_items
  resources :users
  resources :applicants

  get "/" => "home#index"

  get "/signin/new" => "sessions#new", as: :new_session
  post "/signin" => "sessions#create", as: :sessions
  delete "/signout" => "sessions#destroy"

  post "/menus/UpdateActiveMenu" => "menus#updateActiveMenu"
  post "/orderdeliver/:id" => "orders#deliverOrder"
  get "/reports" => "reports#index", as: :reports
  get "/reports/:id" => "reports#invoice", as: :invoice
  post "/orders" => "orders#create", as: :new_orders
  get "/orders" => "orders#index", as: :orders
  post "/orders/confirm" => "orders#confirm"
  get "/orders/cart" => "orders#cart", as: :carts
  post "/order_items/change/:id" => "order_items#change"
  post "/order_items/update/:id" => "order_items#update"
  post "/users/:id/removeAsClerk" => "users#removeAsClerk"
  post "/users/:id/makeAsClerk" => "users#makeAsClerk"
end

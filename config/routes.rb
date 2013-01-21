Mytechbooks::Application.routes.draw do

  authenticated :user do
    root :to => 'home#index'
  end

  root :to => redirect("/users/sign_in")

  devise_for :users

  resources :users
  resources :books
  get "/search", :to => "search#index", :as => :search

end

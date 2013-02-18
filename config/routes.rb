Mytechbooks::Application.routes.draw do

  authenticated :user do
    root :to => 'home#index'
  end

  devise_for :users

  devise_scope :user do
    match '/' => 'devise/sessions#new'
  end

  resources :users
  resources :books
  get "/search", :to => "search#index", :as => :search

end

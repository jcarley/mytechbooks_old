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

  namespace :aws, defaults: {format: 'json'} do
    get "/get_init_signature",   :to => "uploads#init"
    get "/get_chunk_signature",  :to => "uploads#chunk"
    get "/get_end_signature",    :to => "uploads#end_signature"
    get "/get_list_signature",   :to => "uploads#list"
    get "/get_delete_signature", :to => "uplaods#delete"
    get "/get_all_signatures",   :to => "uploads#all"
  end


end

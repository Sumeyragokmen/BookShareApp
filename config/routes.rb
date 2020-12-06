Rails.application.routes.draw do
  get 'users/index'  
  devise_for :users
  root 'welcome#index'

  resources :books do
    resources :comments
    resources :trades
  end

  match '/books/:id/trades/:id/approve', to: 'trades#approve', via: 'get'
  match '/books/:id/trades/:id/deny', to: 'trades#deny', via: 'get'

  resources :dashboard

  get 'users/:id' => 'users#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, :only =>[:show]

end

#Rails.application.routes.draw do
#  #get 'comments/index'
#  get 'users/index'
#  #get 'dashboard/index'
#  devise_for :users
#  root 'welcome#index'
#  resources :books do#

#    resources :comments
#  end
#  resources :dashboard
#  match '/users',   to: 'users#index',   via: 'get'
#  match '/users/:id',     to: 'users#show',       via: 'get'
#  #devise_for :users, :path_prefix => 'd'
#  resources :users, :only =>[:show]
Rails.application.routes.draw do
  # get 'user_account_links/index'

  # get 'friend/create'

  # get 'friend/destroy'

  # get 'transaction/create'

  # get 'transaction/destroy'

  # get 'credit/create'

  # get 'credit/destroy'

  # get 'account/index'

  # get 'account/show'

  # get 'account/create'

  # get 'account/destroy'

  devise_for :users

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/dashboard", to: "pages#dashboard"

  resources :user_account_links, only: [:index] # ???
  resources :accounts, only: [:show, :create, :destroy] do
    resources :transactions, only: [:create, :destroy]
    resources :credits, only: [:create, :destroy]
    resources :friends, only: [:create, :destroy]
  end

end

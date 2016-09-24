Rails.application.routes.draw do
  get 'user_account_links/index'

  get 'friend/create'

  get 'friend/destroy'

  get 'transaction/create'

  get 'transaction/destroy'

  get 'credit/create'

  get 'credit/destroy'

  get 'account/index'

  get 'account/show'

  get 'account/create'

  get 'account/destroy'

  get 'pages/dashboard'

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

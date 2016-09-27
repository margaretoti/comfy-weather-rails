Rails.application.routes.draw do
  api_version(module: 'V1',
              header: {
              name: 'Accept',
              value: 'application/vnd.comfy-weather-server.com; version=1' },
              defaults: { format: :json }) do
    root "users#index"
    resources :users, only: :index
    resources :outfits, only: [:index, :create]
    resources :authentications, only: [:create, :destroy]
    resources :article_of_clothings, only: :index
  end
  match 'auth/:provider/callback', to: 'v1/authentications#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'v1/authentications#destroy', as: 'signout', via: [:get, :post]
end

Rails.application.routes.draw do
  api_version(module: 'V1',
              header: {
              name: 'Accept',
              value: 'application/vnd.comfy-weather-server.com; version=1' },
              defaults: { format: :json }) do
    resources :users, only: :index
    resources :outfits, only: [:index, :create]
    root "users#index"
    resources :users, only: [:index, :create, :destroy]
    match 'auth/:provider/callback', to: 'users#create', via: [:get, :post]
    match 'auth/failure', to: redirect('/'), via: [:get, :post]
    match 'signout', to: 'users#destroy', as: 'signout', via: [:get, :post]
  end
end

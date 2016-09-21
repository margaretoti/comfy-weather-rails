Rails.application.routes.draw do
  api_version(module: 'V1',
              header: {
              name: 'Accept',
              value: 'application/vnd.comfy-weather-server.com; version=1' },
              defaults: { format: :json }) do
<<<<<<< HEAD
    resources :users, only: :index
    resources :outfits, only: [:index, :create]
    root "users#index"
=======
>>>>>>> e35cf66... add authentication requests testing suite
    resources :users, only: [:index, :create, :destroy]
    root 'users#create'
  end
  match 'auth/:provider/callback', to: 'v1/users#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'v1/users#destroy', as: 'signout', via: [:get, :post]
end

Rails.application.routes.draw do
  api_version(module: 'V1',
              header: {
              name: 'Accept',
              value: 'application/vnd.comfy-weather-server.com; version=1' },
              defaults: { format: :json }) do
    resources :users, only: [:index, :create]
    resources :outfits, only: [:index, :create]
    resources :authentications, only: [:create, :destroy]
    resources :article_of_clothings, only: :index
    resources :forecasts, only: :create
    resources :categories, only: :index
    constraints(Authenticated.new) do
      resources :users, only: [:update]
    end
  end
end

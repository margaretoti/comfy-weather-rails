Rails.application.routes.draw do
  api_version(module: 'V1',
              header: {
              name: 'Accept',
              value: 'application/vnd.comfy-weather-server.com; version=1' },
              defaults: { format: :json }) do
    resources :users, only: [:index, :show, :create]
    resources :authentications, only: [:create, :destroy]
    resources :forecasts, only: :create
    resources :categories, only: :index
    resources :weather_types, only: [:index, :create, :update]
    constraints(Authenticated.new) do
      resources :users, only: [:update]
      resources :outfits, only: [:index, :create, :update]
      match '/rating', to: 'outfits#update', via: [:patch]
      resources :article_of_clothings, only: [:index, :create]
    end
  end
end

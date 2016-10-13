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
<<<<<<< HEAD
      resources :outfits, only: [:index, :create, :update]
=======
      resources :outfits, only: [:index, :show, :create, :update]
>>>>>>> 2ed260cc190ebd8df9d150898e659e82c729cc6e
      match '/rating', to: 'outfits#update', via: [:patch]
      resources :article_of_clothings, only: [:index, :create]
      resources :article_of_clothings, only: :index , param: :category_id
      resources :article_of_clothings, only: :create
    end
  end
end

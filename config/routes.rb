Rails.application.routes.draw do
  resources :gas_stations, only: [:show, :index] do
    collection do
      get :search
      get :autocomplete
      get '/by_province/:province' , to: 'gas_stations#by_province'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

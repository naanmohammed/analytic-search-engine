Rails.application.routes.draw do
  resources :searches, only: [:index, :create]
  get 'searches/:ip_address', to: 'searches#show', constraints: {ip_address: /.*/}
  get '/ip', to: 'searches#ip', as: 'search_ip'
  root to: 'searches#index'


  resources :articles, only: [:index] do
    collection do
      get :search
    end
  end

  # root 'articles#index'
end

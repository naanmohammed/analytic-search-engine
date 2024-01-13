Rails.application.routes.draw do
  resources :searches, only: [:index, :create, :show]
  get '/ip', to: 'searches#ip', as: 'search_ip'
  root to: 'searches#index'


  resources :articles, only: [:index] do
    collection do
      get :search
    end
  end

  # root 'articles#index'
end

Rails.application.routes.draw do
  #devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # root "home#index"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    root to: "devise/sessions#new"
  end
 

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  # root "funcionarios#index"
  resources :funcionarios
  resources :departamentos
  resources :cargos
  resources :users, only: [:new, :create]


  get 'selection', to: 'pages#selection'

  get "/funcionarios", to: "funcionarios#index"
  get "/funcionarios/:id", to: "funcionarios#show"

  get "/cargos", to: "cargos#index"
  get "/departamentos", to: "departamentos#index"
end

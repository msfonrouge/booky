Rails.application.routes.draw do
    resources :publishers do
    collection do
      get :clear
    end
  end
    resources :authors do
    collection do
      get :clear
    end
  end
  resources :books  do
    collection do
      get :clear
    end
  end
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

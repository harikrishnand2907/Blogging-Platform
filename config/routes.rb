Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"
  
  resources :posts do
    collection do
      post :import
    end
    member do
      get :download_pdf
    end
  end
end

Rails.application.routes.draw do
  root 'tests#index'

  get :signup, to: 'users#new'

  get :login, to: 'sessions#new'
  post :login, to: 'sessions#create'
  
  delete :logout, to: 'sessions#destroy'

  resources :users, only: :create

  resources :tests do
    resources :questions, shallow: true do
      resources :answers, shallow: true
    end

    member do
      post :start
    end
  end

  resources :test_passages, only: %i[show update] do
    get :result, on: :member
  end
end

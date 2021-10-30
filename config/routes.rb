Rails.application.routes.draw do
  root 'tests#index'

  devise_for :users, path_names: { sign_up: :signup, sign_in: :login, sign_out: :logout },
             controllers: { sessions: 'users/sessions' }

  resources :tests, only: [:index, :show] do
    member do
      post :start
    end
  end

  resources :test_passages, only: %i[show update] do
    member do
      get :result
      post :gist
    end
  end

  namespace :admin do
    root 'tests#index'
    
    resources :tests do
      resources :questions, except: :index, shallow: true do
        resources :answers, except: :index, shallow: true
      end
    end

    resources :gists, only: [:index]
  end
end

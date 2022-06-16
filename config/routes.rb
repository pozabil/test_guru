Rails.application.routes.draw do
  root 'tests#index'

  devise_for :users, path_names: { sign_up: :signup, sign_in: :login, sign_out: :logout },
             controllers: { sessions: 'users/sessions' }

  resource :feedback, only: [:show, :new, :create]

  resources :tests, only: [:index, :show] do
    member do
      post :start
    end
  end

  resources :test_passages, only: [:show, :update] do
    member do
      get :result
      post :gist
    end
  end

  resources :badges, only: [:index, :show]
  resources :user_badges, only: [:index, :show]

  namespace :admin do
    root 'tests#index'
    
    resources :tests do
      member do
        patch :update_inline
        get :update_inline, to: redirect('admin/')
        patch :publish
      end
      
      resources :questions, except: :index, shallow: true do
        resources :answers, except: :index, shallow: true
      end
    end

    resources :gists, only: [:index]

    resources :badges do
      member do
        patch :update_inline
        get :update_inline, to: redirect('admin/badges')
      end
    end
  end
end

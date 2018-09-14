Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :new, :create]
  resource :session, only: [:destroy, :new, :create]
  resources :bands do
    resources :albums, only: [:new]
  end

  resources :albums, except: [:index, :new] do
    resources :tracks, only: [:new]
  end

  resources :tracks, except: [:index, :new] do
    resources :notes, only: [:new]
  end

  resources :notes, except: [:index, :new]
end

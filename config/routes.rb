module Constraints
  class SignedIn
    def matches?(request)
      request.env["warden"].authenticated?
    end
  end
end

Gamenight::Application.routes.draw do
  constraints Constraints::SignedIn.new do
    get "/" => "dashboards#show", as: :signed_in_root
  end

  root "homes#show"
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:show, :new, :create]
  resource :dashboard, only: [:show]

  resources :games, only: [:new, :create] do
    member do
      post 'know' => 'knows#create'
      delete 'know' => 'knows#destroy'
    end
  end

  resources :groups, only: [:new, :create, :show] do
    resources :locations, only: [:new, :create]
    resources :invitations, only: [:new, :create]
    resource :rsvp, only: [:create, :destroy, :update]
    get "rsvp" => "rsvps#create"
  end

  resources :invitations, only: [:show, :update, :destroy]

  resources :boxes, only: [:none] do
    resource :assignment, only: [:update]
  end

  resources :locations, only: [:show, :update] do
    resources :games, only: [:new, :create]
  end

  namespace :search do
    resources :games, only: [:index]
  end

  namespace :my do
    resources :boxes, only: [:show, :destroy] do
      member do
        post "merge" => "merges#create"
      end
    end
  end
end

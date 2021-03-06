module Constraints
  class SignedIn
    def matches?(request)
      request.env["warden"].authenticated?
    end
  end
end

Gamenight::Application.routes.draw do
  resource :bgg_import, only: :create
  resources :users, only: [:none] do
    resources :password_resets, only: [:edit, :update]
  end
  resources :password_resets, only: [:new, :create]
  constraints Constraints::SignedIn.new do
    get "/" => "dashboards#show", as: :signed_in_root
  end

  root "homes#show"
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:show, :new, :create]
  resource :settings, only: [:edit, :update]
  resource :dashboard, only: [:show]

  resources :games, only: [:new, :create]

  resources :boxes, only: [:destroy] do
    member do
      patch 'assign' => 'assignments#update'
    end
  end

  resources :locations, only: :none do
    resources :boxes, only: [:destroy]
  end

  resources :groups, only: [:new, :create, :show] do
    resources :locations, only: [:new, :create]
    resources :invitations, only: [:new, :create]
    get "rsvp/:token/:request" => "rsvps#create", as: :rsvp_request
    resource :rsvp, only: [:create, :destroy, :update]
    resources :votes, only: [:update, :destroy]
    member do
      delete "leave" => "group_memberships#destroy"
    end
  end

  resources :invitations, only: [:show, :update, :destroy]

  resources :locations, only: [:show, :update] do
    resources :games, only: [:new, :create]
  end

  namespace :search do
    resources :games, only: [:index]
  end
end

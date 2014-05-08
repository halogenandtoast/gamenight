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
  resource :settings, only: [:edit, :update]
  resource :dashboard, only: [:show]

  resources :games, only: [:new, :create]

  resources :boxes, only: [:destroy] do
    member do
      patch 'assign' => 'assignments#update'
    end
  end

  resources :groups, only: [:new, :create, :show] do
    resources :locations, only: [:new, :create]
    resources :invitations, only: [:new, :create]
    resource :rsvp, only: [:create, :destroy, :update]
    resources :votes, only: [:update, :destroy]
    get "rsvp" => "rsvps#create"
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

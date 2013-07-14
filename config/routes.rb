MasteryProject::Application.routes.draw do

  root to: "poems#new"

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"

  resources :poems
  resources :users
  resources :sessions

  namespace :api do
    resources :poems, only: [:update], defaults: { format: "JSON" }
  end
end

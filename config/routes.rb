MasteryProject::Application.routes.draw do
  root to: "poems#new"
  resources :poems

  namespace :api do
    resources :poems, only: [:update], defaults: { format: "JSON" }
  end
end

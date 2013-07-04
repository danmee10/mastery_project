MasteryProject::Application.routes.draw do
 root to: "poems#new"
 resources :poems
end

CommitsCorpus::Application.routes.draw do
  resources :commits, only: [:index]
  root "commits#search"
end

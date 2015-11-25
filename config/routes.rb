Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"
  get "help" => "static_pages#help"

  namespace :admin do
    root "dashboard#home"
    resources :subjects
  end
end

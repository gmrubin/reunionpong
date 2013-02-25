Reunionpong::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users


  resources :teams

  root :to => 'public#index'
end

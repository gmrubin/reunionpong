Reunionpong::Application.routes.draw do

  mount Forem::Engine, :at => '/forums'

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users


  resources :teams do
    member do
      get 'join'
      get 'leave'
    end
  end

  authenticated :user do
    root :to => "teams#index"
  end

  match "tos" => 'public#tos'

  root :to => 'public#index'
end

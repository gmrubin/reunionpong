Reunionpong::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users


  resources :teams do
    member do
      get 'join'
      get 'leave'
    end
  end

  root :to => 'public#index'
end

# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path_names: { sign_out: 'logout' }
  as :user do
    get 'login', to: 'devise/sessions#new'
  end


  root to: 'institutions#index'
  resources :institutions, param: :slug do
    resources :institutional_units, param: :slug, path: 'institutional-units' do
      resources :unit_administrators, path: 'administrators'
      resources :departments, param: :slug do
        resources :department_administrators, path: 'administrators'
      end
    end
  end
end

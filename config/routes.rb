# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'institutions#index'
  resources :institutions, param: :slug do
    resources :institutional_units, only: [:index, :show, :new, :create], param: :slug, path: 'institutional-units' do
      resources :administrators
      resources :departments, param: :slug do
        resources :administrators
      end
    end
  end
end

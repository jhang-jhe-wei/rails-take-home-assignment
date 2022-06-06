# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'tracking_lists#index'
  post 'sessions', to: 'sessions#switch_user'
  resources :tracking_lists, except: :show do
    member do
      post 'down'
    end
  end
end

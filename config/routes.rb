# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'tracking_lists#index'
  post 'sessions', to: "sessions#switch_user"
end

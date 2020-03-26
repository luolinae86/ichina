# frozen_string_literal: true

Rails.application.routes.draw do
  resources :orders
  resources :merchants
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users'
  }

  root to: 'users#index'
  resources :users

  mount API::Base, at: '/api'
  mount GrapeSwaggerRails::Engine => '/api/doc'
end

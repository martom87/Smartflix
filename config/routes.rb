# frozen_string_literal: true

require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  resources :movies, only: %i[show], param: :title
  post 'login' => 'auth#login'
end

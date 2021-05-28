# frozen_string_literal: true

require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' # mount Sidekiq::Web in your Rails app
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

# typed: strict
# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'

  get 'redirect', to: 'home#redirect', as: :redirect

  get 'gearscore.php', to: 'legacy#show'
  get 'rankings.php', to: 'legacy#index'

  constraints RegionConstraint.new do
    scope ':region/:realm/:name' do
      resources :comments, only: :create
      root 'characters#show', as: :character
    end

    get ':region(/:realm)', to: 'characters#index', as: :characters
  end

  get '/ping.txt', to: proc { [200, {}, ['ok']] }

  root 'home#show'
end

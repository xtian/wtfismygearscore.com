# frozen_string_literal: true
Rails.application.routes.draw do
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

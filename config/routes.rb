Rails.application.routes.draw do
  get 'redirect', to: 'home#redirect', as: :redirect

  constraints RegionConstraint.new do
    get ':region/:realm/:name', to: 'characters#show', as: :character
    get ':region(/:realm)', to: 'characters#index', as: :characters
  end

  root to: 'home#show'
end

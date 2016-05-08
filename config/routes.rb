Rails.application.routes.draw do
  get 'redirect', to: 'home#redirect', as: :redirect

  get ':region/:realm/:name', to: 'characters#show', as: :character
  get ':region(/:realm)', to: 'characters#index', as: :characters

  root to: 'home#show'
end

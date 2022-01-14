Rails.application.routes.draw do
  root to: 'home#index'
  get 'warehouse', to: 'warehouse#show'
end

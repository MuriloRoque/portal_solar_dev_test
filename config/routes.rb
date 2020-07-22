Rails.application.routes.draw do
  root to: 'power_generators#index'
  resources :home, only: %i[index]
end

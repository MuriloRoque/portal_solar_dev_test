Rails.application.routes.draw do
  root to: 'power_generators#index'
  resources :home, only: %i[index]

  get '/test', to: 'power_generators#test'
end

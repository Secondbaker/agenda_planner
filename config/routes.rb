Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.
  get '/redirect', to: 'example#redirect', as: :redirect
end

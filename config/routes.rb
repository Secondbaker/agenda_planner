Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.
  get '/redirect', to: 'example#redirect', as: 'redirect'
  get '/callback', to: 'example#callback', as: 'callback'
  get '/calendars', to: 'example#calendars', as: 'calendars'
  get '/events', to: 'example#events', as: 'events'
  get '/calendar/:calendar_id', to: 'example#calendar', as: 'calendar', calendar_id: /[^\/]+/
end

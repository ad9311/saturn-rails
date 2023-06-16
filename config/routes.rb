Rails.application.routes.draw do
  root 'dashboard#index'

  # Devise
  devise_for :users, skip: [:registrations]

  # Dashboard
  resources :dashboard, only: %i[index]

  # Thoughts
  get 'thoughts/favorites', to: 'thoughts#favorites'
  patch 'thoughts/:id/bookmark', to: 'thoughts#bookmark'
  patch 'thoughts/:id/unbookmark', to: 'thoughts#unbookmark'
  resources :thoughts, only: %i[index new edit create destroy update]

  # Recoveries
  get 'recoveries/favorites', to: 'recoveries#favorites'
  resources :recoveries
  patch 'recoveries/:id/report', to: 'recoveries#submit_report'
  get 'recoveries/:id/renew', to: 'recoveries#renew'
  patch 'recoveries/:id/renew', to: 'recoveries#submit_renew'
  patch 'recoveries/:id/bookmark', to: 'recoveries#bookmark'
  patch 'recoveries/:id/unbookmark', to: 'recoveries#unbookmark'

  # Stoppers
  resources :recoveries do
    resources :stoppers, only: %i[index new create]
  end

  # Routines
  get 'routines/favorites', to: 'routines#favorites'
  resources :routines
end

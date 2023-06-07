Rails.application.routes.draw do
  root 'dashboard#index'

  # Devise
  devise_for :users, skip: [:registrations]

  #Dashboard
  resources :dashboard, only: %i[index]

  #Recoveries
  resources :recoveries, only: %i[index show new create destroy]
  patch 'recoveries/:id/report', to: 'recoveries#submit_report'
  get 'recoveries/:id/renew', to: 'recoveries#renew'
  patch 'recoveries/:id/renew', to: 'recoveries#submit_renew'
end

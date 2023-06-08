Rails.application.routes.draw do
  root 'dashboard#index'

  # Devise
  devise_for :users, skip: [:registrations]

  #Dashboard
  resources :dashboard, only: %i[index]

  #Recoveries
  resources :recoveries
  patch 'recoveries/:id/report', to: 'recoveries#submit_report'
  get 'recoveries/:id/renew', to: 'recoveries#renew'
  patch 'recoveries/:id/renew', to: 'recoveries#submit_renew'

  #Stoppers
  resources :recoveries do
    resources :stoppers, only: %i[index new create]
  end
end

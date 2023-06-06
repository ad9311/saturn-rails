Rails.application.routes.draw do
  root 'dashboard#index'
  devise_for :users, skip: [:registrations]
  resources :dashboard, only: %i[index]
  resources :recoveries, only: %i[index show new create destroy]
  patch 'recoveries/:id/report', to: 'recoveries#submit_report'
end

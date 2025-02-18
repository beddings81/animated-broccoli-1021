Rails.application.routes.draw do
  resources :doctors, only: [:show]

  delete "/doctor/:doctor_id/:patient/:patient_id", to: 'doctor_patients#delete'

  resources :patients, only: [:index]

  resources :hospitals, only: [:show]
end

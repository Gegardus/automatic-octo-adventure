# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path: 'accounts', controllers: { registrations: 'users/registrations' }

  resource :current_user_passwords, only: %i[edit update]

  resources :quick_assessment, only: %i[new show]
  resource :assertiveness_assessments, only: %i[edit update]
  resource :responsiveness_assessments, only: %i[edit update]
  resource :immigration_quizzes, only: %i[new create]

  resources :users, only: %i[index show update]
  resources :invitations, only: %i[new create]
  resource :application_progress, only: %i[show], controller: 'application_progress'

  root 'home#show'

  resource :home_carousel, only: %i[edit update destroy]
  resource :current_user, only: %i[show]

  resources :applicant_resources, only: %i[index]

  resources :resources
  resources :embedded_youtube, only: :show, controller: 'embedded_youtubes'
  resources :decline_inquiries, only: %i[edit update]
  resources :approve_inquiries, only: %i[update]
  resources :suv_applications, only: %i[show index]

  resources :applicant_mentor_requests, only: %i[create]
  resources :mentor_requests, only: %i[index show new create edit update]
  resource :applicant_mentor, only: %i[show], controller: 'applicant_mentor_requests'
  resources :conversation_comments, only: %i[show update]
  resources :comments, only: %i[destroy]

  resources :help_requests, only: %i[index show edit update]
  resources :applicant_help_requests, only: %i[index new create show]
  resources :skipped_steps, except: %i[edit update]

  resource :inquiry_steps, only: [] do
    resource :applicant_detail, except: %i[index destroy], controller: 'inquiry_steps/applicant_details'
    resources :other_applicants, only: %i[new create], controller: 'inquiry_steps/other_applicants'
    resources :applicant_education_records, controller: 'inquiry_steps/applicant_education_records'
    resources :applicant_work_experiences, controller: 'inquiry_steps/applicant_work_experiences'
    resources :applicant_skills, controller: 'inquiry_steps/applicant_skills'
    resource :additional_informations, only: %i[show edit update], controller: 'inquiry_steps/additional_informations'
    resource :your_interest, only: %i[show edit update], controller: 'inquiry_steps/your_interests'
    resource :confirmations, only: %i[show edit update], controller: 'inquiry_steps/confirmations'
  end

  resources :suv_application_team_names, only: %i[new create]
  resources :modules, only: :index

  get 'registration_documents_steps/:section', to: 'registration_documents_steps#show', as: :registration_documents_steps
  patch 'registration_documents_steps/:section', to: 'registration_documents_steps#update', as: :registration_document_step
  get 'immigration_modules/:section', to: 'immigration_modules#show', as: :immigration_modules
  get 'refining_your_idea_modules/:section', to: 'refining_your_idea_modules#show', as: :refining_your_idea_modules
  patch 'refining_your_idea_modules/:section', to: 'refining_your_idea_modules#update', as: :refining_your_idea_module
  get 'business_models/:section', to: 'business_models#show', as: :business_models
  patch 'business_models/:section', to: 'business_models#update', as: :business_model
end

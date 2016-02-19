Rails.application.routes.draw do

  root :to => 'home#show'

  devise_for :users, class_name: 'User',
             :controllers =>
                 {
                     registrations: 'users/registrations',
                     invitations: 'users/invitations',
                     sessions: 'users/sessions',
                 }

  get 'dashboard' => 'dashboard#show'

  resources :users do
    resources :projects
  end

  resources :projects do
    resources :tasks
  end

end

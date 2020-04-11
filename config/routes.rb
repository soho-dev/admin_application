Rails.application.routes.draw do
  get '/dashboard' => "dashboard#index"

  devise_for :users, controllers: { sessions: 'users/sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :loan_applications
  root to: 'dashboard#index'
end

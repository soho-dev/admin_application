Rails.application.routes.draw do
  get '/dashboard' => "dashboard#index"
  resources :users
  devise_for :users, controllers: { sessions: 'users/sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :loan_applications
  post "/address_check" => "loan_applications#address_check"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :application_services do
        get :decision_check, on: :member
      end
      resources :location_services
    end
  end
  root to: 'dashboard#index'
end

Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get :dashboard, to: 'pages#dashboard'
  resources :flats, only: %i[create show index] do
    resources :booking_requests, only: %i[new create show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  root to: 'pages#home'
  get :dashboard, to: 'pages#dashboard'
  patch 'booking_requests/:id', to: "booking_requests#accept", as: :accept_booking
  get 'booking_request/:id/confirm', to: "booking_requests#confirm", as: :confirm_booking
  get 'booking_request/:id/pay', to: "booking_requests#pay", as: :pay_booking
  # Users are created by Devise
  resources :flats, only: %i[new create show index] do
    # A Booking Request needs a User and a Flat.
    resources :booking_requests, only: %i[new create destroy]
    # Reviews don't need to be nested if the creation and view are on the show page of the booking request
    # Chats only need of a flat id
    resources :chatrooms, only: %i[new show destroy]
    # Messages are created by the chat so don't need a route.
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

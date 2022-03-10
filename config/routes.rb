Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  root to: 'pages#home'
  get :dashboard, to: 'pages#dashboard'
  patch 'booking_requests/:id', to: "booking_requests#accept", as: :accept_booking
  delete 'booking_requests/:id', to: "booking_requests#decline", as: :decline_booking
  get 'booking_request/:id/confirm', to: "booking_requests#confirm", as: :confirm_booking
  put 'booking_request/:id/pay', to: "booking_requests#pay", as: :pay_booking

  resources :chat_rooms, only: :index
  # Users are created by Devise
  resources :flats, only: %i[new create show index edit update] do
    # A Booking Request needs a User and a Flat.
    resources :booking_requests, only: %i[new create destroy]
    # Reviews don't need to be nested if the creation and view are on the show page of the booking request
    # Chats only need of a flat id
    resources :chat_rooms, only: %i[new create show destroy] do
      resources :messages, only: :create
    end
    # Messages are created by the chat so don't need a route.
    resources :amenities, only: %i[new create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :booking_requests, only: :show
end

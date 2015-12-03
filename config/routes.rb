Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  devise_scope :user do
    authenticated :user do
      root to: "exams#index", as: "authenticated_root"
    end

    unauthenticated do
      root to: "devise/sessions#new", as: "unauthenticated_root"
    end
  end
  resources :questions
  resources :exams
  namespace :admin do
    root "subjects#index"
    resources :subjects
    resources :questions
    resources :users
    resources :exams
  end

  match "/users/:id/finish_signup", to: "users#finish_signup",
    via: [:get, :patch], as: :finish_signup
end

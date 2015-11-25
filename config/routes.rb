Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root to: "exams#index", as: "authenticated_root"
    end

    unauthenticated do
      root to: "devise/sessions#new", as: "unauthenticated_root"
    end
  end
  resources :exams
  namespace :admin do
    root "subjects#index"
    resources :subjects
    resources :questions
  end
end

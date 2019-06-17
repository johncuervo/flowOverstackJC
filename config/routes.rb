Rails.application.routes.draw do

  root to: "questions#index"
  devise_for :users

  resources :questions do
    resources :answers
    resources :comments
  end

  resources :answers do
    resources :comments
  end

end

Rails.application.routes.draw do

  root to: "questions#index"
  devise_for :users

  resources :questions do
    resource :votes
    resources :answers
    resources :comments
  end

  resources :answers do
    resource :votes
    resources :comments
  end

end

Rails.application.routes.draw do
  root to: "questions#index"
  devise_for :users


end

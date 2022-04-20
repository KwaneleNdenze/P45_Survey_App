Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'surveys#index'
  resources :surveys do
    resources :questions do
      resources :answers
    end
  end
end
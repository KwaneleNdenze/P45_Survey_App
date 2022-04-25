Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'surveys#index'
  resources :surveys do
    get 'report', to: 'surveys#report', as: 'survey_report'
    resources :questions do
      get 'next', to: 'questions#next', as: 'next_question'
      resources :answers
    end
  end
end

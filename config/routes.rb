Rails.application.routes.draw do
  get 'profiles/show'

  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :posts do
    resources :comments
  end

  get ':username', to: 'profiles#show', as: :profile
  # get ':username', to: 'profiles#edit', as: :profile

  root "posts#index"
end

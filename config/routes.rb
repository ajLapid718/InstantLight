Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :posts do
    resources :comments
  end

  get ':username', to: 'profiles#show', as: :profile

  root "posts#index"
end

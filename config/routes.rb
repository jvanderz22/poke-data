Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' }
  get 'users/:id', to: 'users#show'
  resources :teams, only: [:index, :create, :destroy]


  resources :battles
  resources :user_teams
  get 'team_session', to: 'team_session#show'
  get 'data', to: 'data#show'
  get 'data/:id', to: 'data#update_display'

end

Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' }
  get :teams, to: 'teams#index'
  post :teams, to: 'teams#create'
  resources :battles
  resources :user_teams
  get 'team_session', to: 'team_session#show'
  get 'data', to: 'data#show'
  get 'data/:id', to: 'data#update_display'

end

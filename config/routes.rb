Rails.application.routes.draw do
  devise_for :users

  resources :friendships do
    member do
      put "add" => "friendships#add"
    end
  end
  
  resources :users
  
  get 'games/preferences', to: 'games#preferences'
  post '/games', to: 'games#index'

  resources :games

  root 'friendships#show'
  
  post '/games/like', to: 'games#like'
  post '/games/dislike', to: 'games#dislike'
  post '/friendships/new', to: 'friendships#create'
  post '/games/new', to: 'games#new'

  delete '/games/rematch'
  
end

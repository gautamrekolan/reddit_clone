RedditClone::Application.routes.draw do

  match 'login'  => 'user_sessions#new'
  match 'logout' => 'user_sessions#destroy'
  
  match "stories/:id/upvote" => "stories#upvote",      :as => :upvote
  
  resources :stories
  resources :users
  resources :user_sessions

  root :to => "stories#index"

  
end

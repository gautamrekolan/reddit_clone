RedditClone::Application.routes.draw do

  match 'login'  => 'user_sessions#new'
  match 'logout' => 'user_sessions#destroy'
  
  match "stories/:id/upvote"   => "stories#upvote",      :as => :upvote
  match "stories/:id/downvote" => "stories#downvote",    :as => :downvote
  
  resources :stories do
    resources :comments
  end
  
  resources :users
  resources :user_sessions

  root :to => "stories#index"

  
end

RedditClone::Application.routes.draw do
  
  resources :stories do
    resources :comments
  end
  
  resources :users
  resources :user_sessions
  

  match 'login'  => 'user_sessions#new'
  match 'logout' => 'user_sessions#destroy'
  
  match "stories/:id/upvote"   => "stories#upvote",      :as => :upvote
  match "stories/:id/downvote" => "stories#downvote",    :as => :downvote
  
  match "new(/:page)" => "stories#newest",    :as => :stories_sorted_by_new
  match "top(/:page)" => "stories#top",       :as => :stories_sorted_by_top


  root :to => "stories#newest"

  
end

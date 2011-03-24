RedditClone::Application.routes.draw do
  
  resources :votes do
    member do
      get :upvote, :downvote
    end
  end
  
  resources :stories
  resources :users
  resources :user_sessions

  resources :votes, :only => [:upvote, :downvote]
  
  match 'login'  => 'user_sessions#new'
  match 'logout' => 'user_sessions#destroy'
  
  match "upvote(/:story)"            => "votes#upvote",      :as => :upvote

  root :to => "stories#index"

  
end

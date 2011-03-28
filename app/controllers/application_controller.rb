class ApplicationController < ActionController::Base
  
  #-------------------------------------------------
   # Configuration
   #-------------------------------------------------

   # define helper settings
   helper        :all
   helper_method :current_user
   helper_method :current_user_session

   # establish security settings
   protect_from_forgery
   
   # access denied
   rescue_from   CanCan::AccessDenied do |exception|
     flash[:error] = "You must be logged in to do that."
     redirect_to root_path
   end


   #-------------------------------------------------------------------------------
   # Protected instance methods
   #-------------------------------------------------------------------------------
   
   protected

   # AUTHENTICATION
   
   def current_user_session
     @current_user_session ||= UserSession.find
   end

   def current_user
     @current_user ||= current_user_session && current_user_session.user
   end
  
end

class Story < ActiveRecord::Base
  
  #-------------------------------------------------------------------------------
   # Configuration
   #-------------------------------------------------------------------------------

   # associations
   belongs_to :user
   
   has_many :votes
   has_many :comments
   
   
   # -------------------------------------------------
   #  Public methods
   # -------------------------------------------------
   
   def site
     require 'open-uri'
     URI.parse(check_http(self.link)).host.gsub(/^www\./, '')
   end

   def check_http(link)
     link.starts_with?("http://") ? link : "http://#{link}"
   end

   def upvoted_by_user?(user)
     voted_by_user(user, "up")
   end
   
   def downvoted_by_user?(user)
     voted_by_user(user, "down")
   end
   
   # -------------------------------------------------
   #  Private methods
   # -------------------------------------------------

   def voted_by_user(user, up_or_down)
     voted = false
     unless user.nil?
       user_vote = Vote.where(:story_id => self.id, :user_id => user.id).first
       voted = true if user_vote && user_vote.up_or_down == up_or_down
     end
     voted
   end

end

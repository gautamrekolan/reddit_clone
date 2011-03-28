class Story < ActiveRecord::Base
  
  #-------------------------------------------------------------------------------
   # Configuration
   #-------------------------------------------------------------------------------

   # associations
   belongs_to :user
   
   has_many :votes
   
   
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

end

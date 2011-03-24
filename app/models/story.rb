class Story < ActiveRecord::Base
  
  #-------------------------------------------------------------------------------
   # Configuration
   #-------------------------------------------------------------------------------

   # associations
   belongs_to :user
   
   has_many :votes

end

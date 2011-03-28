class Vote < ActiveRecord::Base
  
  #-------------------------------------------------------------------------------
   # Configuration
   #-------------------------------------------------------------------------------

   # associations
   belongs_to :user
   belongs_to :story

end

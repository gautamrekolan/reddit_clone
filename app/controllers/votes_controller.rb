class VotesController < ApplicationController

  #-------------------------------------------------
  # Setup
  #-------------------------------------------------

  load_and_authorize_resource
  
  # -------------------------------------------------
  #  Public methods
  # -------------------------------------------------

  def upvote
    logger.debug "upvoted!"
    
    @story.score += 1
    @story.save
    @story.user.karma += 1
    @story.user.save
    
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  
  
  def downvote
    
  end
  
  # def upvote_story
  #   @story.score += 1
  #   @story.save
  #   @story.user.karma += 1
  #   @story.user.save
  #   
  #   respond_to do |format|
  #     format.html { redirect_to @story }
  #     format.js
  #   end
  # end
  
end

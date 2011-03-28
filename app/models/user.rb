class User < ActiveRecord::Base
  
  # -------------------------------------------------
  #  Configuration
  # -------------------------------------------------

  
  acts_as_authentic
  
  ROLES = %w[admin user]
    
  has_many :stories, :dependent => :nullify
  has_many :votes
  
  
  
  
  # -------------------------------------------------
  #  Public methods
  # -------------------------------------------------

  def is?(role)
    role.to_sym == role
  end

  def upvote_story(story)
    
    user_vote = self.votes.find_by_story_id(story.id)
    
    if user_vote
      vote = user_vote.destroy
      point_change = -1
    else
      vote = self.votes.create(:user_id => self.id, :story_id => story.id, :up_or_down => :up)
      point_change = 1
    end
    
    if vote
      story.score += point_change
      story.save      
      story.user.karma += point_change
      story.user.save
    end
  end

end

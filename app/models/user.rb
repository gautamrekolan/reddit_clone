class User < ActiveRecord::Base
  
  # -------------------------------------------------
  #  Configuration
  # -------------------------------------------------

  
  acts_as_authentic
  
  ROLES = %w[admin user]
    
  has_many :stories, :dependent => :nullify
  has_many :votes
  has_many :comments
  
  
  
  
  # -------------------------------------------------
  #  Public methods
  # -------------------------------------------------

  def is?(role)
    role.to_sym == role
  end

  def upvote_story(story)
    vote(story, 'up')
  end
  
  def downvote_story(story)
    vote(story, 'down')
  end
  
  def vote(story, up_or_down)
    up_or_down_opposite = (up_or_down == 'up' ? 'down' : 'up')
    up_or_down_modifier = (up_or_down == 'up' ? 1 : -1 )

    user_vote = self.votes.find_by_story_id(story.id)
    if user_vote
      if user_vote.up_or_down == up_or_down_opposite
        vote = user_vote.update_attributes(:up_or_down => up_or_down.to_sym)
        point_change = 2*up_or_down_modifier
      else 
        vote = user_vote.destroy
        point_change = -1*up_or_down_modifier
      end
    else
      vote = self.votes.create(:user_id => self.id, :story_id => story.id, :up_or_down => up_or_down.to_sym)
      point_change = 1*up_or_down_modifier
    end

    if vote
      story.score += point_change
      story.save      
      story.user.karma += point_change
      story.user.save
    end

  end

end

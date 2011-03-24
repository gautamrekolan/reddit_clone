class User < ActiveRecord::Base
  acts_as_authentic
  
  ROLES = %w[admin user]
    
  has_many :stories, :dependent => :nullify
  
  
  
  
  # -------------------------------------------------
  #  Public methods
  # -------------------------------------------------

  def is?(role)
    role.to_sym == role
  end
  
  def upvote_story(story)
    story.score += 1
    story.save
    story.user.karma += 1
    story.user.save
  end
end

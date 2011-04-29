class Story < ActiveRecord::Base
  
  #-------------------------------------------------------------------------------
  # Configuration
  #-------------------------------------------------------------------------------

  # associations
  belongs_to :user

  has_many :votes
  has_many :comments

  # scopes
  scope :newest, order("created_at desc")
  scope :top, order("score desc, created_at desc")

  # -------------------------------------------------
  #  Public methods
  # -------------------------------------------------

  def site
    require 'open-uri'
    URI.parse(self.full_link).host.gsub(/^www\./, '')
  end

  def full_link
    link.starts_with?("http://") ? link : "http://#{link}"
  end
  
  def site_link
    site.starts_with?("http://") ? site : "http://#{site}"
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
  
  private
  
  def voted_by_user(user, up_or_down)
    voted = false
    unless user.nil?
      user_vote = Vote.where(:story_id => self.id, :user_id => user.id).first
      voted = true if user_vote && user_vote.up_or_down == up_or_down
    end
    voted
  end

end

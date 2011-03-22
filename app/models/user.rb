class User < ActiveRecord::Base
  acts_as_authentic
  
  ROLES = %w[admin user]
  
  
  has_many :stories, :dependent => :nullify
  
  
  
  
  # -------------------------------------------------
  #  Publig methods
  # -------------------------------------------------

  def is?(role)
    role.to_sym == role
  end
  
end

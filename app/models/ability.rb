class Ability
  include CanCan::Ability
    
  def initialize(user)
      user ||= User.new
      
      role = (user.role.nil?) ? :dummy : user.role.to_sym
      if self.respond_to?(role, true)
        self.send(role, user)
      end
      
      self.send(:guest, user)
    end  
    
  def admin(user)
    can :manage,      :all
    
    can :assign_role, User do |u|
      u != user
    end
    
  end

  def user(user)
    can :read,     Story
    can :create,   Story
    can :update,   Story, :user_id => user.id
    can :destroy,  Story, :user_id => user.id
    
    can :update,   User, :id => user.id
    
    can :vote,     Story
  end
  
  def guest(user)
    can :read,    Story
    can :create,  User
  end
  
end
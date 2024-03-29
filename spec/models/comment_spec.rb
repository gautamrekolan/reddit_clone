require 'spec_helper'

describe Comment do
  
  # -------------------------------------------------
  #  Main Stuff
  # -------------------------------------------------
  
  before(:each) do
    @user  = Factory(:user)
    @story = Factory(:story)
    
    @attr = {       
      :comment => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", 
      :story   => @story
    }
  end
 
  it "should create a new instance given valid attributes" do
   @user.comments.create!(@attr)
  end
  
  # -------------------------------------------------
  #  Associations
  # -------------------------------------------------
      
  describe "user associations" do    
    
    before(:each) do
      @comment = @user.comments.create!(@attr)
    end

    it "should have a user attribute" do
      @comment.should respond_to(:user)
    end

    it "should have the right associated user" do
      @comment.user_id.should == @user.id
      @comment.user.should == @user
    end
    
  end

  describe "story associations" do
    
    before(:each) do
      @comment = @user.comments.create!(@attr)
    end

    it "should have a votes attribute" do
      @comment.should respond_to(:story)
    end
  
    it "should have the right associated story" do
      @comment.story_id.should == @story.id
      @comment.story.should == @story
    end
  
  end
   
  # -------------------------------------------------
  #  Validations
  # -------------------------------------------------
  
  describe "validations" do
    
    it "should require a comment" do
      pending "Incomplete feature: comment validation"
    end
    
  end
  
  # -------------------------------------------------
  #  Methods
  # -------------------------------------------------

end

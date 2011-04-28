require 'spec_helper'

describe Vote do
  
  # -------------------------------------------------
  #  Main Stuff
  # -------------------------------------------------
  
  before(:each) do
    @user  = Factory(:user)
    @story = Factory(:story)
    
    @attr = {       
      :up_or_down => :up, 
      :story      => @story
    }
  end
 
  it "should create a new instance given valid attributes" do
   @user.votes.create!(@attr)
  end
  
  # -------------------------------------------------
  #  Associations
  # -------------------------------------------------
      
  describe "user associations" do    
    
    before(:each) do
      @vote = @user.votes.create!(@attr)
    end

    it "should have a user attribute" do
      @vote.should respond_to(:user)
    end

    it "should have the right associated user" do
      @vote.user_id.should == @user.id
      @vote.user.should == @user
    end
    
  end

  describe "story associations" do
    
    before(:each) do
      @vote = @user.votes.create!(@attr)
    end

    it "should have a votes attribute" do
      @vote.should respond_to(:story)
    end
  
    it "should have the right associated story" do
      @vote.story_id.should == @story.id
      @vote.story.should == @story
    end
  
  end
   
  # -------------------------------------------------
  #  Validations
  # -------------------------------------------------
  
  
  # -------------------------------------------------
  #  Methods
  # -------------------------------------------------

end

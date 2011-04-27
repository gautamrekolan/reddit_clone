require 'spec_helper'

describe Comment do
  
  # -------------------------------------------------
  #  Main Stuff
  # -------------------------------------------------
  
  before(:each) do
    @user = Factory(:user)
    @attr = {       
      :title         => "Story Title", 
      :link          => "http://ser.example.com/test", 
    }
  end
 
  it "should create a new instance given valid attributes" do
   @user.stories.create!(@attr)
  end
  
  # -------------------------------------------------
  #  Associations
  # -------------------------------------------------
      
  describe "user associations" do    
    
    before(:each) do
      @story = @user.stories.create(@attr)
    end

    it "should have a user attribute" do
      @story.should respond_to(:user)
    end

    it "should have the right associated user" do
      @story.user_id.should == @user.id
      @story.user.should == @user
    end
    
  end

  describe "vote associations" do
    
    before(:each) do
      @story     = @user.stories.create(@attr)
      @vote     = Factory(:vote, :story => @story, :user => @user)
    end

    it "should have a votes attribute" do
      @story.should respond_to(:votes)
    end
  
    it "should remove user reference from votes on delete" do
      @user.destroy
      Vote.find_by_id(@vote.id).user.should be_nil
    end
  
  end

  describe "comment associations" do
    
    before(:each) do
      @story    = @user.stories.create(@attr)
      @comment  = Factory(:comment, :story => @story, :user => @user)
      @vote     = Factory(:vote, :story => @story, :user => @user)
    end
    
    it "should have a comments attribute" do
      @story.should respond_to(:comments)
    end
  
    it "should remove user reference from comments on delete" do
      @user.destroy
      Comment.find_by_id(@comment.id).user.should be_nil
    end
  
  end
   
  # -------------------------------------------------
  #  Validations
  # -------------------------------------------------
  
  describe "validations" do
    
    it "should require a title" do
      pending "Incomplete feature: validating stories"
    end

    it "should require a link" do
      pending "Incomplete feature: validating stories"
    end
    
  end
  
  # -------------------------------------------------
  #  Methods
  # -------------------------------------------------

end

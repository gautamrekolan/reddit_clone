require 'spec_helper'

describe Story do
  
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
      pending "Incomplete feature: story validation"
    end

    it "should require a link" do
      pending "Incomplete feature: story validation"
    end
    
  end
  
  # -------------------------------------------------
  #  Methods
  # -------------------------------------------------
  
  describe "methods" do
    
    before(:each) do
      @story = @user.stories.create(@attr.merge(:link => "www.domainname.com/secondarypage/"))
    end
  
    it "should provide a site from a story link" do
      @story.site.should == 'domainname.com'
    end
  
    it "should provide a full link" do
      @story.full_link.should == 'http://www.domainname.com/secondarypage/'
    end
  
    it "should provide a full site link" do
      @story.site_link.should == 'http://domainname.com'
    end
    
    describe "for votes" do
      
      it "should be able to check if user upvoted story" do
        @vote = Factory(:vote, :story => @story, :user => @user, :up_or_down => :up)
        @story.should     be_upvoted_by_user(@user)
        @story.should_not be_downvoted_by_user(@user)
      end

      it "should be able to check if user downvoted story" do
        @vote = Factory(:vote, :story => @story, :user => @user, :up_or_down => :down)
        @story.should     be_downvoted_by_user(@user)
        @story.should_not be_upvoted_by_user(@user)
      end

      it "should be able to check if user hasn't voted on a story" do
        @story.should_not be_downvoted_by_user(@user)
        @story.should_not be_upvoted_by_user(@user)
      end
      
    end
  
  end

end

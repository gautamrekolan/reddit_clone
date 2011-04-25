require 'spec_helper'

describe User do
  
  # -------------------------------------------------
  #  Main Stuff
  # -------------------------------------------------
  
  before(:each) do
    @attr = { 
      :username              => "example_ser", 
      :email                 => "user@example.com", 
      :password              => "foobar",
      :password_confirmation => "foobar"
    }
  end
 
  it "should create a new instance given valid attributes" do
   User.create!(@attr)
  end

  it "should require a username" do
    no_name_user = User.new(@attr.merge(:username => ""))
    no_name_user.should_not be_valid
  end
  
  it "should require an email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:email => ""))
    long_name_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    # Put a user with given email address into the database.
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  # -------------------------------------------------
  #  Associations
  # -------------------------------------------------
  
  describe "story associations" do

    before(:each) do
      @user = User.create(@attr)
      @s1  = Factory(:story, :user => @user, :created_at => 1.day.ago)
      @s2  = Factory(:story, :user => @user, :created_at => 1.hour.ago)
    end

    it "should have a stories attribute" do
      @user.should respond_to(:stories)
    end
    
    it "should remove user reference from stories on delete" do
      @user.destroy
      [@s1, @s2].each do |story|
        Story.find_by_id(story.id).user.should be_nil
      end
    end
    
  end
  
  # -------------------------------------------------
  #  Validations
  # -------------------------------------------------
  
  
  # -------------------------------------------------
  #  Methods
  # -------------------------------------------------
  
  it "should be able to check role" do
    @user = User.create(@attr)
    @user.should respond_to(:is?)
    
  end

end

# seeing a list of stories

Given /^there are (\d+) stories$/ do |story_count|
  user_hash = {:password => "test123", :password_confirmation => "test123", :role => 'user'}

  @stories = []
  story_count.to_i.times do |i|
    user = User.create(user_hash.merge(:email => "test_user#{i}@test.com", :username => "test_user#{i}"))
    @stories << Story.create(:title => "Story #{i}", :user_id => user.id, :link => "google.com/link#{i}")
  end
end

Then /^I should see (\d+) stories sorted by "([^"]*)"$/ do |story_count, sorted_by|
  visit root_path
  page.should have_css('.story', :count => story_count.to_i)
end

Given /^the following stories exist:$/ do |stories_table|
  stories_table.hashes.each do |story|
      steps %Q{
        Given there is a story
          And the story has title "#{story['title']}"
          And the story links to "#{story['link']}"
          And the story was submitted by "#{story['user']}"
          And the story was created at "#{story['created_at']}"
      }
  end
end


# making a single story and setting attributes

Given /^there is a story$/ do
  @story = Story.create()
end

Given /^the story has title "([^"]*)"$/ do |title|
  @story.title = title
  @story.save
end

Given /^the story links to "([^"]*)"$/ do |link|
  @story.link = link
  @story.save
end

Given /^the current time is "([^"]*)"$/ do |time|
  Timecop.freeze Time.parse(time)
end

Given /^the story was submitted by "([^"]*)"$/ do |user|
  existing_user = User.find_by_username(user)
  if existing_user.nil?
    submitting_user = User.create(:username => user,             
                                  :email => "#{user}@test.com",
                                  :password => "test123", 
                                  :password_confirmation => "test123", 
                                  :role => 'user')
  else
    submitting_user = existing_user
  end
  @story.user = submitting_user
  @story.save
end

Given /^the story was created at "([^"]*)"$/ do |time|
  @story.created_at = Time.parse(time).gmtime
  @story.save
end


# displaying

When /^I display the story$/ do
  visit story_path(@story)
end

Then /^I should be viewing the story$/ do
  visit story_path(@story)
end




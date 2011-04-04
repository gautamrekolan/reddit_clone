# -------------------------------------------------
#  Classes and methods for the step definitions
# -------------------------------------------------

def make_story(title, link, options = {})
  options[:user] ||= "doesnt_matter"
  steps %Q{
    Given I am logged in as "#{options[:user]}"
      And I am on the new story page
      And I fill in the following:
        | Title     | #{title}   |
        | Link      | #{link}    |
      And I press "Create Story"
      And I logout
  }
  @story = Story.find_by_link(link)
  if ! options[:created_at].blank?
    @story.created_at = Time.parse(options[:created_at]).gmtime
    @story.save
  end
  
  {:title => title, :link => link, :user => options[:user], :created_at => @story.created_at}
end


# -------------------------------------------------
#  Step definitions
# -------------------------------------------------

# seeing a list of stories

Given /^there are "([^"]*)" stories$/ do |story_count|
  user_hash = {:password => "test123", :password_confirmation => "test123", :role => 'user'}

  @stories = []
  story_count.to_i.times do |i|
    user = User.create(user_hash.merge(:email => "test_user#{i}@test.com", :username => "test_user#{i}"))
    @stories << Story.create(:title => "Story #{i}", :user_id => user.id, :link => "google.com/link#{i}")
  end
end

Then /^I should see "([^"]*)" stories sorted by "([^"]*)"$/ do |story_count, sorted_by|
  visit root_path
  page.should have_css('.story', :count => story_count.to_i)
end

Given /^the following stories exist:$/ do |stories_table|
  @stories = stories_table.hashes.map do |story|
    make_story(story['title'], story['link'], {:user => story['user'], :created_at => story['created_at']})
  end
end


# displaying

When /^I display the story$/ do
  visit story_path(@story)
end

Then /^I should be viewing the story$/ do
  visit story_path(@story)
end


# interacting

Given /^I am interacting with story titled "([^"]*)"$/ do |title|
  $story = @stories.select{|s| s[:title] == title }.first
end


# votes

When /^I "([^"]*)" the story$/ do |up_or_down_vote|
    steps %Q{ When I follow "#{up_or_down_vote.sub(/vote/, '')}" within ".story .scoring" }
end

Then /^the story should have "([^"]*)" points$/ do |score|
  steps %Q{ Then I should see "#{score}" within ".story .score" }
end

Then /^the story should be "([^"]*)"$/ do |vote|
  if vote == "upvoted"
    find("#story-#{@story.id} .scoring").should have_selector(".upvote.active")
    find("#story-#{@story.id} .scoring").should have_no_selector(".downvote.active")
  elsif vote == "downvoted"
    find("#story-#{@story.id} .scoring").should have_no_selector(".upvote.active")
    find("#story-#{@story.id} .scoring").should have_selector(".downvote.active")
  else
    find("#story-#{@story.id} .scoring").should have_no_selector(".upvote.active")
    find("#story-#{@story.id} .scoring").should have_no_selector(".downvote.active")
  end
end

# comments

Given /^the story "([^"]*)" has "([^"]*)" comments$/ do |story, comment_count|
  steps %Q{ Given I am interacting with story titled "#{story}" }
  
end



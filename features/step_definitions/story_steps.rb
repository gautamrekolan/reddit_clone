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
end


# -------------------------------------------------
#  Step definitions
# -------------------------------------------------

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



# votes

Then /^"([^"]*)" arrow is activated$/ do |up_or_down|
  find(".story .scoring").should have_selector(".#{up_or_down}vote.active")
end

Then /^"([^"]*)" arrow is not activated$/ do |up_or_down|
  find(".story .scoring").should_not have_selector(".#{up_or_down}vote.active")
end


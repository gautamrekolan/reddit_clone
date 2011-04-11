# -------------------------------------------------
#  Classes and methods for the step definitions
# -------------------------------------------------
def leave_comment(comment, story, options = {})
  options[:user] ||= "doesnt_matter"
  steps %Q{
    Given I am logged in as "#{options[:user]}"
      And I am on the story page for "#{story}"
      And I fill in the following:
        | comment | #{comment} |
      And I press "submit"
      And I logout
  }
  # @comment = Comment.last
  # if ! options[:created_at].blank?
  #   @comment.created_at = Time.parse(options[:created_at]).gmtime
  #   @comment.save
  # end
  # 
  {:comment => comment, :story => story, :user => options[:user]}
end



# -------------------------------------------------
#  Step definitions
# -------------------------------------------------

Given /^the story "([^"]*)" has the following comments:$/ do |story, comments_table|
  @comments = comments_table.hashes.map do |comment|
    leave_comment(comment['comment'], story, {:user => comment['user']})
  end
end

Given /^the story "([^"]*)" has "([^"]*)" comments$/ do |story, comment_count|
  comment_count.to_i.times do |i|
    leave_comment("Comment #{i}", story)
  end
end
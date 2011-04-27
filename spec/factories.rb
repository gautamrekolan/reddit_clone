Factory.define :user do |user|
  user.sequence(:username)   { |n| "user#{n}" }
  user.sequence(:email)      { |n| "user#{n}@example.com" }
  user.password              "foobar"
  user.password_confirmation "foobar"
  user.role                  "user"
end

Factory.define :story do |story|
  story.sequence(:title)      { |n| "Story Title #{n}" }
  story.link                  "http://www.example.com/example-page/"
  story.association           :user
end

Factory.define :comment do |comment|
  comment.comment           "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
  comment.association       :story
  comment.association       :user
end

Factory.define :vote do |vote|
  vote.up_or_down        :up
  vote.association       :story
  vote.association       :user
end

# Factory.sequence :email do |n|
#   "person-#{n}@example.com"
# end
# 
# Factory.define :micropost do |micropost|
#   micropost.content         "Foo bar"
#   micropost.association     :user
# end

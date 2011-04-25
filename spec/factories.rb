Factory.define :user do |user|
  user.name                  "Caitlin Woodward"
  user.email                 "caitlin@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
  user.role                  "user"
end

Factory.define :story do |story|
  story.sequence(:title)      { |n| "Story Title #{n}" }
  story.link                  "http://www.example.com/example-page/"
  story.association           :user
end

# Factory.sequence :email do |n|
#   "person-#{n}@example.com"
# end
# 
# Factory.define :micropost do |micropost|
#   micropost.content         "Foo bar"
#   micropost.association     :user
# end

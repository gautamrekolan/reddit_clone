# lib/tasks/populate.rake
namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    [Story, User].each(&:delete_all)
    
    User.populate 30 do |user|
      user.username    = Faker::Internet.user_name
      user.email       = Faker::Internet.email(user.username)
      user.role        = 'user'
      user.karma       = 1
      Story.populate 5..20 do |story|
        story.user_id    = user.id
        story.title      = Populator.words(3..12).titleize
        story.link       = "#{Faker::Internet.domain_name}/#{Populator.words(1)}"
        story.created_at = 2.years.ago..Time.now
        story.score      = 1
        
        user.karma += 1
        
        Vote.populate 1 do |vote|
          vote.user_id       = user.id
          vote.story_id      = story.id
          vote.up_or_down    = 'up'
        end
        
        # Comment.populate 0..150 do |comment|
        #   comment.comment     = Populator.paragraphs(1..5)
        #   comment.user_id     = Random.new.rand(1..30) # random user for the comment
        #   comment.created_at  = story.created_at..Time.now
        # end
      end
    end
  end
end
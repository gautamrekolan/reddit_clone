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
      Story.populate 5..20 do |story|
        story.user_id    = user.id
        story.title      = Populator.words(3..12).titleize
        story.link       = "#{Faker::Internet.domain_name}/#{Populator.words(1)}"
        story.created_at = 2.years.ago..Time.now
      end
    end
  end
end
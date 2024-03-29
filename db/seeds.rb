# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


if User.count == 0
  User.create(:username => "Admin", 
              :email => "admin@test.com", 
              :password => "admin", 
              :password_confirmation => "admin", 
              :role => 'admin')
  User.create(:username => "Caitlin", 
              :email => "caitlin@test.com",
              :password => "caitlin", 
              :password_confirmation => "caitlin", 
              :role => 'user')
end
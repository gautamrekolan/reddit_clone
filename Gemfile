#----------------------------------------------
# gem sources
#----------------------------------------------

source "http://rubygems.org"


#----------------------------------------------
# common gems
#----------------------------------------------

# rails, etc.
gem "rack"
gem 'rails', '3.0.3'
gem 'sqlite3-ruby'

# authentication/authorization
gem "authlogic",                                                # For the time being, we're fetching the latest 
        :git => "git://github.com/coroutine/authlogic.git",     # authlogic from a rails 3 branch of a fork of 
        :branch => "rails3"                                     # coroutine's git repo.
gem "cancan"

# other gems
gem "tiny_navigation"


#----------------------------------------------
# environment-specific gems
#----------------------------------------------

# development
group :development do
  gem 'rspec-rails'
  gem 'sqlite3-ruby'
end

# test
group :test do
  gem 'rspec'
  gem "cucumber"
  gem "cucumber-rails"
  gem 'webrat'
  # gem 'factory_girl_rails'
end
#----------------------------------------------
# gem sources
#----------------------------------------------

source 'http://rubygems.org'


#----------------------------------------------
# common gems
#----------------------------------------------

# rails, etc.
gem 'rack'
gem 'rails', '3.0.3'
gem 'sqlite3-ruby'
gem "haml"

# authentication/authorization
gem 'authlogic',                                                # For the time being, we're fetching the latest 
        :git => 'git://github.com/coroutine/authlogic.git',     # authlogic from a rails 3 branch of a fork of 
        :branch => 'rails3'                                     # coroutine's git repo.
gem 'cancan'

# other gems
gem 'jquery-rails'


#----------------------------------------------
# environment-specific gems
#----------------------------------------------

# development
group :development do
  gem 'rspec-rails'
  gem 'sqlite3-ruby'
  gem 'populator'
  gem 'faker'
  gem 'hirb'
  gem "awesome_print"
end

# test
group :test do
  gem 'rspec'
  gem 'factory_girl_rails'
  gem 'cucumber'
  gem 'cucumber-rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'timecop'
  # gem 'factory_girl_rails'
end
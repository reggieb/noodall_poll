# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require 'factory_girl'
require 'faker'

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

def require_files_in_subdirectories(*directories)
  for dir in directories
    Dir["#{File.dirname(__FILE__)}/#{dir}/**/*.rb"].each { |f| require f }
  end
end

require_files_in_subdirectories('support', 'factories')
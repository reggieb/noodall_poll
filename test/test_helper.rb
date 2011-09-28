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

class ActiveSupport::TestCase

  def teardown
    drop_all_mongo_test_data
  end

  def drop_all_mongo_test_data
    MongoMapper.database.collections.each do |coll|
      coll.remove
    end
  end

  def noodle_poll_get(action, parameters = {}, session = nil, flash = nil)
    parameters.merge!(:use_route => :noodall_poll)
    get(action, parameters, session, flash)
  end

end


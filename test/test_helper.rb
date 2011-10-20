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
  require 'noodall_poll/custom_assertions'
  include NoodallPoll::CustomAssertions

  def teardown
    drop_all_mongo_test_data
  end

  def drop_all_mongo_test_data
    MongoMapper.database.collections.each do |coll|
      coll.remove
    end
  end

#  def noodall_poll_get(action, parameters = {}, *args)
#    noodall_poll_request(:get, action, parameters, *args)
#  end
#
#  def noodall_poll_post(action, parameters = {}, *args)
#    noodall_poll_request(:post, action, parameters, *args)
#  end
#
#  private
#  def noodall_poll_request(type, action, parameters, *args)
##    parameters.merge!(:use_route => :noodall_poll)
#    send(type, action, parameters, *args)
#  end

end


require 'test_helper'

module NoodallPoll
  class ResponseOptionTest < ActiveSupport::TestCase
    def setup
      @poll_response = Factory(:poll_response)
      @poll = Factory(:poll)
      @response_option = Factory(:response_option)
    end

    def test_join_to_poll
      @poll.response_options << @response_option
      @poll.save
      assert(@poll.reload.response_options.include?(@response_option))
    end

#    def test_required_fields
#      response_option = ResponseOption.create
#      required = [:text]
#      required.each do |field|
#        assert(!response_option.errors[field].empty?, "Errors should be present against '#{field}'")
#      end
#    end

  end
end

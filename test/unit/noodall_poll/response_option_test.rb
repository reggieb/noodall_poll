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

    def test_poll
      test_join_to_poll
      assert_equal(@poll, @response_option.poll, "poll should return parent document")
    end

  end
end

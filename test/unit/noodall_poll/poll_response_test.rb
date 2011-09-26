require 'test_helper'

module NoodallPoll
  class PollResponseTest < ActiveSupport::TestCase
    def setup
      @poll_response = Factory(:poll_response)
      @response_option = Factory(:response_option)
    end

    def test_join_to_poll_response
      @response_option.poll_responses << @poll_response
      assert_equal(@response_option, @poll_response.response_option)
    end
  end
end

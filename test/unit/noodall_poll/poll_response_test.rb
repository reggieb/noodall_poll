require 'test_helper'

module NoodallPoll
  class PollResponseTest < ActiveSupport::TestCase
    def setup
      @poll_response = Factory(:poll_response)
      @response_option = Factory(:response_option)
    end


  end
end

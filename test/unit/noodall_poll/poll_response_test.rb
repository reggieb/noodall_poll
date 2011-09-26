require 'test_helper'

module NoodallPoll
  class PollResponseTest < ActiveSupport::TestCase
    def test_creation_of_poll_response
      poll_response = PollResponse.create
      assert(poll_response.created_at)
    end
  end
end

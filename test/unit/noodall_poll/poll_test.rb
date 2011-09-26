require 'test_helper'

module NoodallPoll
  class PollTest < ActiveSupport::TestCase

    def setup
      @poll = Factory(:poll)
    end

    def test_creation_of_poll
      poll = Poll.create
      assert(poll.created_at)
    end
  end
end
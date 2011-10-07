require 'test_helper'

module NoodallPoll
  class PollsControllerTest < ActionController::TestCase

    def setup
      @poll = Factory(:poll)
    end

    def test_show
      get :show, :id => @poll.id
      assert_response :success
      assert_equal(@poll, assigns(:poll), "Poll should be passed to template")
    end


  end
end


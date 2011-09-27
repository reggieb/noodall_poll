require 'test_helper'

module NoodallPoll
  class PollsControllerTest < ActionController::TestCase

    def setup
      @poll = Factory(:poll)
    end

    def test_index_when_no_polls_present
      remove_polls_created_in_setup
      noodle_poll_get :index
      assert_response :success
      assert_equal([], assigns(:polls), "An empty array should be passed to the template when there are no polls")
      assert_select('h2', :text => 'No polls found')
    end


    private
    def remove_polls_created_in_setup
      teardown
    end

  end
end


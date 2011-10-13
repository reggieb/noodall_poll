require 'test_helper'

module NoodallPoll
  class PollsControllerTest < ActionController::TestCase

    def setup
      @poll = Factory(:poll)
      @response_option = @poll.response_options.first
    end

    def test_show
      noodall_poll_get :show, :id => @poll.id
      assert_response :success
      assert_equal(@poll, assigns(:poll), "Poll should be passed to template")
    end

    def test_update
      starting_number_of_poll_responses = PollResponse.count
      noodall_poll_post :update, :id => @poll.id, :poll_response => @response_option.text
      assert_equal(starting_number_of_poll_responses + 1, PollResponse.count, '1 Poll response should have been added to database')
      poll_response = PollResponse.last
      assert_equal(poll_response.poll_id, @poll.id, "poll_id should match poll")
      assert_equal(poll_response.text, @response_option.text, "text should match response option text")
      assert(session[@poll.submitted_label], "session should show poll has been submitted")
      assert(cookies[@poll.submitted_label], "cookie should show poll has been submitted")
      assert_equal(@poll.thank_you_message, flash[:notice], "User should see thank you message")
    end


  end
end


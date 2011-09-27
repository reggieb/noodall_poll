require 'test_helper'

module NoodallPoll
  class ResponseOptionTest < ActiveSupport::TestCase
    def setup
      @poll_response = Factory(:poll_response)
      @poll = Factory(:poll)
      @response_option = Factory(:response_option)
    end

    def test_join_to_poll_response
      @response_option.poll_responses << @poll_response
      assert_equal(@poll_response, @response_option.poll_responses.first)
    end

    def test_join_to_poll
      @poll.response_options << @response_option
      assert_equal(@poll, @response_option.poll)
    end

    def test_required_fields
      response_option = ResponseOption.create
      required = [:text]
      required.each do |field|
        assert(!response_option.errors[field].empty?, "Errors should be present against '#{field}'")
      end
    end

    def test_results
      assert_response_option_result_zero('at start of test')
      test_join_to_poll_response
      assert_equal(1, @response_option.result)
      @response_option.poll_responses << PollResponse.create
      assert_equal(2, @response_option.result)
    end

    def test_add_poll_response
      starting_number_of_poll_responses = PollResponse.all.count
      assert_response_option_result_zero('at start of test')
      @response_option.register_poll_response
      assert_equal(starting_number_of_poll_responses + 1, PollResponse.all.count, "Poll response should be added to databasse")
      assert_equal(1, @response_option.result, "Response option result should now be one")
    end

    private
    def assert_response_option_result_zero(message = nil)
      assert_equal(0, @response_option.result, "Response option result should be zero#{ ' ' + message if message}.")
    end
  end
end

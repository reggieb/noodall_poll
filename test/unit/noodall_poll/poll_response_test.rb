require 'test_helper'

module NoodallPoll
  class PollResponseTest < ActiveSupport::TestCase
    def setup
      @poll_response = Factory(:poll_response)
      @poll = @poll_response.poll
      @response_option = @poll.response_options.first
    end

    def test_setup
      assert_equal(@response_option.text, @poll_response.text, "text should return @response_option.text")
    end

    def test_responses_for_poll
      create_poll_responses
      group = PollResponse.responses_for_poll(@poll)
      assert_equal(5 + 1, group[@response_option.text])
      assert_equal(2, group[@response_two.text])
      assert_equal(8, group[@response_three.text])
    end

    def test_poll_result
      test_responses_for_poll
      expected = [
        {:text => @response_option.text, :count => 6},
        {:text => @response_two.text, :count => 2},
        {:text => @response_three.text, :count => 8}
      ]
      assert_equal(expected, @poll.reload.results)
    end

    private
    def create_poll_responses
      @response_two = ResponseOption.new(:text => 'two')
      @poll.response_options << @response_two
      @response_three = ResponseOption.new(:text => 'three')
      @poll.response_options << @response_three
      @poll.save
      (1..5).each{ create_poll_response_for(@response_option)}
      (1..2).each{ create_poll_response_for(@response_two)}
      (1..8).each{ create_poll_response_for(@response_three)}
    end

    def create_poll_response_for(response_option)
      PollResponse.create(:poll_id => response_option.poll.id, :text => response_option.text)
    end
  end
end

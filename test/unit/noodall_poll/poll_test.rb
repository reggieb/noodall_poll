require 'test_helper'

module NoodallPoll
  class PollTest < ActiveSupport::TestCase

    def setup
      @poll = Factory(:poll)
      @response_option = Factory(:response_option)
    end

    def test_required_fields
      poll = Poll.create
      required = [:name, :question]
      required.each do |field|
        assert(!poll.errors[field].empty?, "Errors should be present against '#{field}'")
      end
    end

    def test_button_label_default
      @poll.button_label = nil
      assert_equal('Submit', @poll.button_label, "The button label should return 'Submit' if set as nil.")
    end

    def test_thank_you_message_default
      @poll.thank_you_message = nil
      assert_equal('Thank you', @poll.thank_you_message, "The thank you message should return 'Thank you' if set as nil")
    end

    def test_join_to_response_option
      @poll.response_options << @response_option
      assert_equal(@response_option, @poll.response_options.first)
    end

    def test_results
      assert_equal({}, @poll.result, "Poll result should return an empty hash when no matching polls reponses exist")
      test_join_to_response_option
      assert_equal([@response_option.text], @poll.result.keys, "The response option text should appear in the poll result keys")
      assert_equal([@response_option.result], @poll.result.values, "The response option result should appear in the poll result values")
    end

    def test_result_with_many_poll_responses
      test_join_to_response_option
      add_three_poll_responses_to_response_option
      add_second_response_option
      results = {
        @second_response_option.text => 0,
        @response_option.text => 3
      }
      assert_equal(results, @poll.result, 'Resultant hash should have reponse option text as keys and their results as values')
    end

    private
    def add_three_poll_responses_to_response_option
      (1..3).to_a.each{|n| @response_option.poll_responses << PollResponse.create}
    end

    def add_second_response_option
      @second_response_option = ResponseOption.create(:text => 'blue')
      @poll.response_options <<  @second_response_option
    end


  end
end
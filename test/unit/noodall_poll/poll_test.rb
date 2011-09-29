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

    def test_name_cannot_be_blank
      @poll.name = ""
      assert(@poll.invalid?, "Poll should be invalid if name is blank")
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

    def test_creation_of_poll_with_response_options
      name =  'test poll'
      params = {
        :name => name,
        :question => 'What is you favourite animal',
        :response_options => [
          {:position => 0, :text => 'dog'},
          {:position => 2, :text => 'mouse'},
          {:position => 1, :text => 'cat'},
          {:position => 3, :text => 'monkey'}
        ]
      }
      starting_number_of_polls = Poll.all.count
      starting_number_of_response_options = ResponseOption.all.count
      poll = Poll.create(params)
      assert_equal(starting_number_of_polls + 1, Poll.all.count, "One poll should be added to the database")
      assert_equal(starting_number_of_response_options + 4, ResponseOption.all.count, "Three response options should be added to database")
      assert_equal(name, poll.name, "The most recent poll should have the name #{name}")
      assert_equal(%w{dog cat mouse monkey}, poll.response_options.collect{|o| o.text}, 'The three response options should be associated with the poll and in position order.')
    end

    def test_update_attribute_with_response_options
      name =  'test poll'
      params = {
        :name => name,
        :question => 'What is you favourite animal',
        :response_options => [
          {:position => 0, :text => 'dog'},
          {:position => 2, :text => 'mouse'},
          {:position => 1, :text => 'cat'},
          {:position => 3, :text => 'monkey'}
        ]
      }
      starting_number_of_polls = Poll.all.count
      starting_number_of_response_options = ResponseOption.all.count
      @poll.update_attributes(params)
      assert_equal(starting_number_of_polls, Poll.all.count, "No polls should be added to the database")
      assert_equal(starting_number_of_response_options + 4, ResponseOption.all.count, "Three response options should be added to database")
      assert_equal(name, @poll.name, "The poll should have the name #{name}")
      assert_equal(%w{dog cat mouse monkey}, @poll.response_options.collect{|o| o.text}, 'The three response options should be associated with the poll and in position order.')
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
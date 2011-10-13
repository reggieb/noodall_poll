require 'test_helper'

module NoodallPoll
  class PollTest < ActiveSupport::TestCase

    def setup
      @poll = Factory(:poll)
      @response_option = ResponseOption.new(:text => Faker::Lorem.sentence)
      set_starting_numbers
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
      @poll.save
      assert_equal(@response_option, @poll.reload.response_options.last)
    end

    def test_creation_of_poll_with_response_options
      name =  'test poll'
      params = {
        :name => name,
        :question => 'What is you favourite animal',
        :response_options => [
          {:text => 'dog'},
          {:text => 'mouse'},
          {:text => 'cat'},
          {:text => 'monkey'}
        ]
      }
      @poll = Poll.create(params)
      assert_poll_added_to_database
      assert_equal(4, @poll.response_options.length, "Response options should be added")
      assert_equal(name, @poll.name, "The most recent poll should have the name #{name}")
      assert_equal(%w{dog mouse cat monkey}, @poll.response_options.collect{|o| o.text}, 'The response options should be associated with the poll and in order.')
    end

    def test_update_attribute_with_response_options_reversed
      test_creation_of_poll_with_response_options
      set_starting_numbers
      name =  'test poll update'
      params = {
        :name => name,
        :question => 'What is you favourite animal',
        :response_options => @poll.response_options.reverse.collect{|r| {:id => r.id, :text => r.text}}
      }
      @poll.update_attributes(params)
      assert_poll_not_added_to_database
      assert_equal(4, @poll.response_options.length, "Response options should still be 4")
      assert_equal(name, @poll.name, "The poll should have the name #{name}")
      assert_equal(%w{monkey cat mouse dog}, @poll.response_options.collect{|o| o.text}, 'The response options should be associated with the poll and in order.')
    end

    def test_submitted_label
      expected_label = "submitted_#{@poll.id}".to_sym
      assert_equal(expected_label, @poll.submitted_label, "Submitted label sould be '#{expected_label}'")
    end

    private
    def add_second_response_option
      @second_response_option = ResponseOption.create(:text => 'blue')
      @poll.response_options <<  @second_response_option
    end

    def set_starting_numbers
      @starting_number_of_polls = Poll.all.count
#      @starting_number_of_response_options = ResponseOption.all.count
    end

  end
end
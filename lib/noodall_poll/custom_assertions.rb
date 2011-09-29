
module NoodallPoll
  module CustomAssertions
    def assert_poll_added_to_database
      assert_equal(@starting_number_of_polls + 1, Poll.count, "A poll should be added to the database")
    end

    def assert_response_option_added_to_database
      assert_equal(@starting_number_of_response_options + 1, ResponseOption.count, "A response option should be added to the database")
    end

    def assert_poll_not_added_to_database
      assert_equal(@starting_number_of_polls, Poll.count, "A poll should be added to the database")
    end

    def assert_response_option_not_added_to_database
      assert_equal(@starting_number_of_response_options , ResponseOption.count, "A response option should not be added to the database")
    end

    def assert_poll_deleted_from_database
      assert_equal(@starting_number_of_polls - 1, Poll.count, "A poll should be deleted from the database")
    end

    def assert_errors_detected_on(object)
      assert(!object.errors.empty?, "Errors should be detected on #{object.inspect}")
    end
  end
end

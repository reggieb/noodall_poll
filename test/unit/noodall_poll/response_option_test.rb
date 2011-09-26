require 'test_helper'

module NoodallPoll
  class ResponseOptionTest < ActiveSupport::TestCase
    def test_creation_of_response_option
      response_option = ResponseOption.create
      assert(response_option.created_at)
    end
  end
end

module NoodallPoll
  module Admin
    class PollsController < ApplicationController
      def index
        @polls = Poll.all

      end
    end
  
  end
end

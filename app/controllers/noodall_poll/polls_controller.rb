module NoodallPoll
  class PollsController < ApplicationController
    def index
      @polls = Poll.all

    end
    
  
  end
end

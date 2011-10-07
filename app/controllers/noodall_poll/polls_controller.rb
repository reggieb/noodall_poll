module NoodallPoll
  class PollsController < ApplicationController
    def show
      @poll = Poll.find(params[:id])
      render :partial => 'show'
    end
    
  
  end
end

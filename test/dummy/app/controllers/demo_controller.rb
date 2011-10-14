class DemoController < ApplicationController

  def index
    @poll = NoodallPoll::Poll.first
  end
  
end

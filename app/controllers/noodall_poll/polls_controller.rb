module NoodallPoll
  class PollsController < ApplicationController

    def index
      respond_to do |format|
        format.css
      end
    end
    

    def show
      get_poll
      if params[:show_poll_form] and params[:show_poll_form] == 'yes'
        render :partial => 'form'
      elsif params[:show_poll_form] and params[:show_poll_form] == 'no'
        render :partial => 'show'
      elsif session[@poll.submitted_label] or cookies[@poll.submitted_label]
        render :partial => 'show'
      else
        render :partial => 'form'
      end
    end

    def update
      get_poll
      if params[:poll_response]
        PollResponse.create(:poll_id => @poll.id, :text => params[:poll_response])
        session[@poll.submitted_label] = Time.now
        cookies[@poll.submitted_label] = {
          :value => session[@poll.submitted_label],
          :expires => 1.year.from_now
        }
        flash[:notice] = @poll.thank_you_message
      end
      render :partial => 'show'
    end


    private
    def get_poll
      @poll = Poll.find(params[:id])
    end
  
  end
end

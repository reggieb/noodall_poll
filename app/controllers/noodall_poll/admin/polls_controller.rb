module NoodallPoll
  module Admin
    class PollsController < ApplicationController
      def index
        @polls = Poll.all

      end

      def new
        @poll = Poll.new
      end

      def create
        @poll = Poll.new
        update_poll
      end

      def edit
        get_poll
        render :action => "new"
      end

      def update
        get_poll
        update_poll
      end

      def show
        get_poll
      end

      private
      def get_poll
        @poll = Poll.find(params[:id])
      end

      def update_poll
        @poll.attributes = params[:poll]
        if @poll.save
          redirect_to admin_poll_url(@poll)
        else
          render :action => "new"
        end
      end

    end
  
  end
end

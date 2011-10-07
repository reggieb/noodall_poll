module NoodallPoll
  module Admin
    class PollsController < ApplicationController

      layout 'noodall_admin'

      def index

        @polls = Poll.all
        respond_to do |format|
          format.html
          format.css
        end
      end

      def new
        @poll = Poll.new
      end

      def create
        new
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

      def destroy
        get_poll
        @poll.destroy
        redirect_to admin_polls_path
      end

      def new_response_option_form_element
        if request.xhr?
          render :partial => 'new_response_option_form'
        else
          flash[:notice] = 'Please enable JavaScript for this site'
          redirect_to admin_polls_path
        end
      end

     private
      def get_poll
        @poll = Poll.find(params[:id])
      end

      def update_poll

        @poll.attributes = processed_poll_params
        if @poll.save
          redirect_to edit_admin_poll_path(@poll)
        else
          render :action => "new"
        end
      end

      def processed_poll_params
        if params[:response_options]
          add_ids_to_response_options_param_values
          params[:poll][:response_options] = params[:response_options].values
        end
        params[:poll]
      end

      def add_ids_to_response_options_param_values
        params[:response_options].each{|id, values| values[:id] = id if mongo_id_pattern =~ id}
      end

      def mongo_id_pattern
        /[0-9a-f]{20}/
      end

    end
  
  end
end

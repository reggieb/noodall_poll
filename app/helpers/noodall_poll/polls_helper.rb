module NoodallPoll
  module PollsHelper

    def show_poll_form?
      @poll and !session[@poll.submitted_label] and !cookies[@poll.submitted_label]
    end
  end
end

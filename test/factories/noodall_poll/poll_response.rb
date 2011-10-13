require 'factories/noodall_poll/poll'
poll = Factory(:poll)

Factory.define(:poll_response, :class => NoodallPoll::PollResponse) do |poll_response|
  poll_response.poll { poll }
  poll_response.text { poll.response_options.first.text }
end

module NoodallPoll
  class PollResponse
    include MongoMapper::Document

    key :text, String
    timestamps!

    belongs_to :poll, :class_name => 'NoodallPoll::Poll'

    def self.responses_for_poll(poll)
      poll_responses = where(:poll_id => poll.id)
      hash = Hash.new
      poll_responses.each do |poll_response|
        if hash[poll_response.text]
          hash[poll_response.text] += 1
        else
          hash[poll_response.text] = 1
        end
      end
      return hash
    end


  end
end

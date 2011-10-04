module NoodallPoll
  class ResponseOption
    include MongoMapper::EmbeddedDocument
    key :text, String
    key :position, Integer

    many :poll_responses, :class => NoodallPoll::PollResponse
#    belongs_to :poll, :class_name => 'NoodallPoll::Poll'

    validates_presence_of(:text)


    def result
      poll_responses.length
    end

    def register_poll_response
      poll_responses << PollResponse.create
    end

  end
end

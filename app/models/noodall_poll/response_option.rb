module NoodallPoll
  class ResponseOption
    include MongoMapper::Document
    key :text, String
    timestamps!

    many :poll_responses, :class => NoodallPoll::PollResponse
    belongs_to :poll, :class_name => 'NoodallPoll::Poll'

    validates_presence_of(:text)

    def result
      poll_responses.length
    end
  end
end

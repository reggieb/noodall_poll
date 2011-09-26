module NoodallPoll
  class PollResponse
    include MongoMapper::Document

    timestamps!

    belongs_to :response_option, :class_name => 'NoodallPoll::ResponseOption'
  end
end

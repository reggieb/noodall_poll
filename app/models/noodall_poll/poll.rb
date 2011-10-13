module NoodallPoll
  class Poll
    include MongoMapper::Document
    key :name, String
    key :question, String
    key :button_label, String
    key :thank_you_message, String
    timestamps!

    many :response_options, :class => NoodallPoll::ResponseOption

    validates_presence_of(:name, :question)

    def button_label
      super.blank? ? 'Submit' : super
    end

    def thank_you_message
      super || 'Thank you'
    end

    def submitted_label
      @submitted_label ||= "submitted_#{self.id}".to_sym
    end

    def results
      poll_responses = PollResponse.responses_for_poll(self)
      output = Array.new
      for response_option in response_options
        number = poll_responses[response_option.text] || 0
        output << {:text => response_option.text, :count => number}
        poll_responses.delete(response_option.text)
      end
      poll_responses.each do |text, count|
        output << {:text => text, :count => count}
      end
      return output
    end
      
  end
end
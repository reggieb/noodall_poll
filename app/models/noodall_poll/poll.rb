module NoodallPoll
  class Poll
    include MongoMapper::Document
    key :name, String
    key :question, String
    key :button_label, String
    key :thank_you_message, String
    timestamps!

    many :response_options, :class => NoodallPoll::ResponseOption, :order => 'position'

    validates_presence_of(:name, :question)

    def button_label
      super.blank? ? 'Submit' : super
    end

    def thank_you_message
      super || 'Thank you'
    end

    def result
      result = Hash.new
      response_options.each{|o| result[o.text] = o.result}
      return result
    end
  end
end
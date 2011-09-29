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

    validate :delete_response_options_if_new_and_problem

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

    # I can't find a better way of doing this
    # Without it, if you create a poll together with response options
    # and the poll is invalid, the poll doesn't get saved, but the
    # response options are saved.
    def delete_response_options_if_new_and_problem
      if new? and (name.blank? or question.blank?)
        response_options.each{|e| e.delete}
      end
    end
  end
end
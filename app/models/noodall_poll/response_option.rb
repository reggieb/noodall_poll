module NoodallPoll
  class ResponseOption
    include MongoMapper::EmbeddedDocument
    key :text, String

    validates_presence_of(:text)

    def poll
      _parent_document
    end
  end
end

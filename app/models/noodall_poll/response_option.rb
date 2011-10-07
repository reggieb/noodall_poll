module NoodallPoll
  class ResponseOption
    include MongoMapper::EmbeddedDocument
    key :text, String

    validates_presence_of(:text)
  end
end

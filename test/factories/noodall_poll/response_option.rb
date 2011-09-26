Factory.define :reponse_option, :class => NoodallPoll::ResponseOption do |response_option|
  response_option.text { Faker::Lorem.sentence }
end

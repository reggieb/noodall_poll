Factory.define :poll, :class => NoodallPoll::Poll do |poll|
  poll.name       { Faker::Lorem.sentence }
  poll.question   { Faker::Lorem.paragraph }
end

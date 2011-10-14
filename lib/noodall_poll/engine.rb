module NoodallPoll
  class Engine < Rails::Engine
    isolate_namespace NoodallPoll
    initializer 'polls.helper' do |app|
      ActionView::Base.send :include, PollsHelper
    end
  end
end

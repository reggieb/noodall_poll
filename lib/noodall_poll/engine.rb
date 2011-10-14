module NoodallPoll
  class Engine < Rails::Engine
    isolate_namespace NoodallPoll

    initializer "set menu" do |app|
      Noodall::UI.menu_items['Polls'] = :noodall_poll_admin_polls_path
    end
    initializer 'polls.helper' do |app|
      ActionView::Base.send :include, PollsHelper
    end
  end
end

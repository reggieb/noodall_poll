Dummy::Application.routes.draw do

  root :to => 'demo#index'

end

# Not sure why, but NoodallPoll routes need to be declared before Noodall routes
require 'noodall_poll/routes'
NoodallPoll::Routes.draw Dummy::Application

require 'noodall/routes'
Noodall::Routes.draw Dummy::Application



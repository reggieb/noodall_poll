Rails.application.routes.draw do

  mount NoodallPoll::Engine => "/noodall_poll"

end

require 'noodall/routes'
Noodall::Routes.draw Dummy::Application

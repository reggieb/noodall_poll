Rails.application.routes.draw do

  root :to => 'demo#index'

  mount NoodallPoll::Engine => "/noodall_poll"

end

require 'noodall/routes'
Noodall::Routes.draw Dummy::Application

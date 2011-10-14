Rails.application.routes.draw do

  root :to => 'demo#index'

  mount NoodallPoll::Engine => "/noodall_poll"

  namespace(:noodall_poll) do
    namespace(:admin) do
      resources :polls
    end
  end


end

require 'noodall/routes'
Noodall::Routes.draw Dummy::Application

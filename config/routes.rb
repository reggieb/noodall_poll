NoodallPoll::Engine.routes.draw do
  resources :polls

  namespace(:admin) do
    resources :polls
  end

end

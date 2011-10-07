NoodallPoll::Engine.routes.draw do

  namespace(:admin) do
    match(
      'polls/new_reponse_option_form_element' => 'polls#new_response_option_form_element',
      :as => 'new_response_option_element'
    )
    resources :polls
  end

  resources :polls

end

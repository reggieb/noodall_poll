#Rails.application.routes.routes.each do |route|
#
#  if route.respond_to?(:path) and route.defaults[:controller] =~ /^noodall\/admin/
#    #route.defaults[:controller].gsub!(/^noodall\//, "")
#    NoodallPoll::Engine.routes.routes << (route)
#  end
#
#end

#Rails.application.routes.named_routes.routes.each do |route|
#
#  if route[1].respond_to?(:path) and route[1].defaults[:controller] =~ /^noodall\/admin/ and route[1].defaults[:action] == 'index'
#    route[1].defaults[:controller].gsub!(/^noodall\/admin\//, "")
#    puts route[1].defaults.to_s + " " + route[0].to_s
#    match(route[1].path => redirect("/admin/#{route[1].defaults[:controller]}"), :as => route[0])
#  end
#
#end

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

Rails.application.routes.draw do

  namespace(:noodall_poll) do
    namespace(:admin) do
      resources :polls
    end
  end

end



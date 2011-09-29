module NoodallPoll
  module Admin
    module PollsHelper

      def fields_for_existing_reponse_options(reponse_options)
        output = Array.new
        for response_option in @poll.response_options
          output << fields_for_response_option(response_option)
        end
        return output.join("\n").html_safe
      end

      def fields_for_new_response_option
        fields_for_response_option(ResponseOption.new)
      end

      def fields_for_response_option(response_option)
        output = Array.new
        fields_for("response_options[#{response_option.id}]", response_option) do |response_option_fields|
          output << response_option_fields.label(:text, 'Response option')
          output << response_option_fields.text_field(:text)
          output << response_option_fields.hidden_field(:position)
        end
        content_tag('p', output.join("\n").html_safe)
      end


    end
  end
end

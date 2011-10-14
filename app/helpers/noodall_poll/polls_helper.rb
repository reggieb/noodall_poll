module NoodallPoll
  module PollsHelper
    def show_poll_at(poll_id, target)
      content_for :head, stylesheet_link_tag('/noodall_poll/polls.css')
      js = <<EOF
jQuery(function () {
  jQuery('#{target}').load("/noodall_poll/polls/#{ poll_id }");
});
EOF
      javascript_tag(js)
    end
  end
end

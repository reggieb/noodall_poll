require 'test_helper'

module NoodallPoll
  module Admin
    class PollsControllerTest < ActionController::TestCase

      def setup
        @poll = Factory(:poll)
        @response_option = Factory(:response_option)
        @starting_number_of_polls = Poll.count
      end

      def test_index
        get :index
        assert_response :success
        assert_equal([@poll], assigns(:polls), "@poll should be passed to the template")
        assert_select('td', :text => @poll.name)
        assert_link_to_create_new_poll
      end

      def test_index_when_no_polls_present
        remove_polls_created_in_setup
        get :index
        assert_response :success
        assert_equal([], assigns(:polls), "An empty array should be passed to the template when there are no polls")
        assert_select('h2', :text => 'No polls found')
        assert_link_to_create_new_poll
      end

      def test_new
        get :new
        assert_response :success
        assert_empty_poll_passed_to_template
      end

      def test_create
        post(
          :create,
          :noodall_poll_poll => poll_params,
          :response_options => new_response_option_params
        )
        assert_poll_added_to_database
        assert_response :redirect
      end

      def test_failure_to_create
        post(
          :create,
          :noodall_poll_poll => poll_params.merge(:name => nil),
          :response_options => new_response_option_params
        )
        assert_poll_not_added_to_database
        assert_response :success
        assert_errors_detected_on(assigns(:poll))
      end

      def test_create_with_empty_response_option
        response_options = new_response_option_params
        response_options.merge!(new_response_option_params(:text => nil))
        post(
          :create,
          :noodall_poll_poll => poll_params,
          :response_options => response_options
        )
        assert_poll_added_to_database
        assert_response :redirect
        poll = Poll.all.last
        assert_equal(1, poll.response_options.length, "Only one response option should be saved. #{poll.response_options.inspect}")
      end

      def test_edit
        get :edit, :id => @poll
        assert_response :success
        assert_poll_passed_to_template
      end

      def test_update
        name = "New name"
        @poll.name = name
        post :update, :id => @poll, :noodall_poll_poll => @poll.attributes
        assert_response :redirect
        assert_poll_passed_to_template
        assert_equal(name, assigns(:poll).name)
        assert_poll_not_added_to_database
      end

      def test_failure_to_update
        post :update, :id => @poll, :noodall_poll_poll => @poll.attributes.merge(:name => "")
        assert_response :success
        assert_poll_passed_to_template
        assert_errors_detected_on(assigns(:poll))
        assert_poll_not_added_to_database
      end

      def test_show
        get :show, :id => @poll
        assert_response :success
        assert_poll_passed_to_template
        assert_select('h1', :text => @poll.name)
        assert(assigns('show_poll_result'), "@show_poll_result should be passed to veiw as true")
      end

      def test_destroy
        post :destroy, :id => @poll
        assert_poll_deleted_from_database
        assert_response :redirect
      end


      private
      def remove_polls_created_in_setup
        teardown
      end

      def assert_link_to_create_new_poll
        assert_tag(
          :tag => 'a',
          :attributes => {:href => /.*\/noodall_poll\/admin\/polls\/new/},
          :content => 'Create new poll'
        )
      end

      def assert_empty_poll_passed_to_template
        poll = assigns(:poll)
        assert(poll, "Poll should be pass to template as @poll")
        assert_kind_of(Poll, poll)
        assert(poll.new?, "The poll should be new")
      end

      def poll_params
        @poll_params ||= {
          :name => Faker::Lorem.sentence,
          :question => Faker::Lorem.paragraph,
          :button_label => Faker::Lorem.sentence,
          :thank_you_message => Faker::Lorem.paragraph,
        }
      end

      def new_response_option_params(mods = {})
        {
          ResponseOption.new.id => {:text => Faker::Lorem.sentence}.merge(mods)
        }
      end

      def assert_poll_passed_to_template
        assert_equal(@poll, assigns(:poll), "@poll should be passed to template")
      end

    end
  end
end


class UserPoll < Noodall::Component
  key :poll_id, String

  has_one :poll, :class => NoodallPoll::Poll

  allowed_positions :wide

  module ClassMethods
    def poll_options
      lists = NoodallPoll::Poll.all(:fields => [:id, :name], :order => 'name ASC')
      lists.collect{|l| [l.name, l.id.to_s]}
    end

  end
  extend ClassMethods
end

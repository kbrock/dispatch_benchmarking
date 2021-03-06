class IfCodeGenTestbed < Base
  def self.method_added(method_name)
    if method_name.to_s =~ /\Ahandle_(.+)\z/
      handler_methods << $1
      regenerate_dispatch_method
    end
    super
  end

  def self.handler_methods
    @handler_methods ||= []
  end

  def self.regenerate_dispatch_method
    dispatch_table = handler_methods.map { |event_name|
      "event_name.equal?(:#{event_name}) then handle_#{event_name}(event)"
    }.join("\nelsif ")
    class_eval %{
      def call(event)
        event_name = event.name
        if #{dispatch_table}
        end
      end
    }
  end

  attr_reader :event_log

  def initialize
  end

  def handle_foo(event)
    @event_log = event
  end

  def handle_bar(event)
    @event_log = event
  end

  def handle_baz(event)
    @event_log = event
  end
end

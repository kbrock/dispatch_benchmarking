class SendTableTestbed < Base
  @@handler_methods ||= {}
  def self.method_added(method_name)
    if method_name.to_s =~ /\Ahandle_(.+)\z/
      @@handler_methods[$1.to_sym] = method_name.to_sym
    end
    super
  end

  def call(event)
    if (handler_method = @@handler_methods[event.name])
      __send__(handler_method, event)
    end
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

class BindTableTestbed < TestBed
  def self.method_added(method_name)
    if method_name.to_s =~ /\Ahandle_(.+)\z/
      handler_methods[$1.to_sym] = instance_method(method_name)
    end
    super
  end

  def self.handler_methods
    @handler_methods ||= {}
  end

  def call(event)
    if (handler_method = self.class.handler_methods[event.name])
      handler_method.bind(self).call(event)
    end
  end

  def handle_foo(event)
    event_log << event
  end

  def handle_bar(event)
    event_log << event
  end

  def handle_baz(event)
    event_log << event
  end
end

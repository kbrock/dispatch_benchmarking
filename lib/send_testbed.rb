class SendTestbed < TestBed
  def call(event)
    handler_name = "handle_#{event.name}"
    __send__(handler_name, event) if respond_to?(handler_name)
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

class HardcodeTestbed < Base
  def call(event)
    case event.name
    when :foo
      handle_foo(event)
    when :bar
      handle_bar(event)
    when :baz
      handle_baz(event)
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

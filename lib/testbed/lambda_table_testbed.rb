class LambdaTableTestbed < Base
  @@handler_methods = {}
 
  def self.method_added(method_name)
    if method_name.to_s =~ /\Ahandle_(.+)\z/
      @@handler_methods[$1.to_sym] = eval %{
        ->(instance, args) { instance.#{method_name}(args) }
      }
    end
    super
  end
 
  def call(event)
    (@@handler_methods[event.name] or return).call(self, event)
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

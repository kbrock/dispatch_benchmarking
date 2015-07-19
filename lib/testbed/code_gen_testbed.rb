class CodeGenTestbed < Base
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

  # final code will look like:
  # def call(event)
  #   case event.name
  #   when :foo then handle_foo(event)
  #   when :bar then handle_bar(event)
  #   when :baz then handle_baz(event)
  #   end
  # end
  def self.regenerate_dispatch_method
    dispatch_table = handler_methods.map { |event_name|
      "when :#{event_name} then handle_#{event_name}(event)"
    }.join("\n")
    class_eval %{
      def call(event)
        case event.name
        #{dispatch_table}
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

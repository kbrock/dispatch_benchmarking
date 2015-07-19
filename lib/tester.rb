require 'event'
require 'testbed'
require 'hardcode_testbed'
require 'send_testbed'
require 'send_table_testbed'
require 'bind_table_testbed'
require 'code_gen_testbed'
require 'if_code_gen_testbed'
require 'lambda_table_testbed'

require 'benchmark/ips'

class Tester
  def benchmark
    classes = [
        HardcodeTestbed,
        SendTestbed,
        SendTableTestbed,
        BindTableTestbed,
        CodeGenTestbed,
        IfCodeGenTestbed,
        LambdaTableTestbed,
    ]

    puts "ruby: #{RUBY_VERSION}"
    puts

    Benchmark.ips do |x|
      classes.each do |klass|
        x.report(klass.name) { do_test(klass) }
      end
      x.compare!
    end
  end

  def do_test(klass)
    testbed = klass.new
    testbed.call(e1 = Event[:foo])
    testbed.call(e2 = Event[:bar])
    testbed.call(e3 = Event[:baz])
    testbed.call(Event[:buz])
    unless testbed.event_log == [e1, e2, e3]
      raise "#{klass}: #{testbed.event_log.inspect}"
    end
  end
end

if __FILE__ == $0
  Tester.new.benchmark
end

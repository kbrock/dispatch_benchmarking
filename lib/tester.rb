require 'event'
require 'testbed'

require 'benchmark/ips'

class Tester
  E1 = Event[:foo]
  E2 = Event[:bar]
  E3 = Event[:baz]
  BZ = Event[:buz]

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
        x.report(klass.name) { |times| do_test(klass, times) }
      end
      x.compare!
    end
  end

  def do_test(klass, times)
    testbed = klass.new
    i = times
    while i > 0
      testbed.call(E1)
      testbed.call(E2)
      testbed.call(E3)
      testbed.call(BZ)
      i -= 1
    end
    unless testbed.event_log == E3
      raise "#{klass}: #{testbed.event_log.inspect}"
    end
  end
end

if __FILE__ == $0
  Tester.new.benchmark
end

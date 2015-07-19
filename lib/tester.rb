require 'event'
require 'testbed'

require 'benchmark/ips'

class Tester
  E1 = Event[:foo]
  E2 = Event[:bar]
  E3 = Event[:baz]
  BZ = Event[:buz]

  CLASSES = [
    CodeGenTestbed,
    HardcodeTestbed,
    IfCodeGenTestbed,
    SendTableTestbed,
    LambdaTableTestbed,
    SendTestbed,
    BindTableTestbed,
  ]

  def benchmark
    puts "ruby: #{RUBY_VERSION}"
    puts

    Benchmark.ips do |x|
      CLASSES.each do |klass|
        x.report(klass.name) { |times| do_test(klass, times) }
      end
      x.compare!
    end
  end

  def profile
    require 'ruby-prof'

    CLASSES.each do |klass|
      puts
      puts ">>>>>>>>>> #{klass.name} <<<<<<<<<<"
      puts

      result = RubyProf.profile do
        do_test(klass, 200_000)
      end

      printer = RubyProf::FlatPrinter.new(result)
      printer.print(STDOUT)
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
  if ARGV[0] == "-p"
    Tester.new.profile
  else
    Tester.new.benchmark
  end
end

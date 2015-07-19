Avdi Grimm had a great [article] about the performance of dispatching.

This takes that article and puts the values together.

It then takes some of the comments in the notes and adds those to the benchmarks

[article]: http://devblog.avdi.org/2015/06/03/benchmarking-ruby-dispatch-strategies/

Current results for ruby 2.2.2:

```
Calculating -------------------------------------
      CodeGenTestbed    80.548k i/100ms
     HardcodeTestbed    81.159k i/100ms
    IfCodeGenTestbed    69.891k i/100ms
    SendTableTestbed    62.255k i/100ms
  LambdaTableTestbed    56.647k i/100ms
         SendTestbed    33.659k i/100ms
    BindTableTestbed    27.716k i/100ms
-------------------------------------------------
      CodeGenTestbed      2.532M (± 6.4%) i/s -     12.646M
     HardcodeTestbed      2.531M (± 6.0%) i/s -     12.661M
    IfCodeGenTestbed      1.814M (± 5.7%) i/s -      9.086M
    SendTableTestbed      1.381M (± 4.9%) i/s -      6.910M
  LambdaTableTestbed      1.202M (± 5.0%) i/s -      6.005M
         SendTestbed    503.207k (± 3.4%) i/s -      2.524M
    BindTableTestbed    366.951k (± 4.1%) i/s -      1.857M

Comparison:
      CodeGenTestbed:  2531739.9 i/s
     HardcodeTestbed:  2531077.8 i/s - 1.00x slower
    IfCodeGenTestbed:  1814271.1 i/s - 1.40x slower
    SendTableTestbed:  1381374.5 i/s - 1.83x slower
  LambdaTableTestbed:  1201769.9 i/s - 2.11x slower
         SendTestbed:   503206.6 i/s - 5.03x slower
    BindTableTestbed:   366951.1 i/s - 6.90x slower
```

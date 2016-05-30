#!/usr/bin/env ruby

# -------------------------------------------------------
# 01_performace_monitor.rb - Lizzi Sparks - May 2016
#
# Methods:
# - `measure(opt'l Numeric) { block }` : returns the average
# amount of time, in seconds, taken to execute block `Numeric`
# times. If `Numeric` not specified, default is once.
#
# NOTE: I had terrible trouble with this one at first because
# I thought that this program was monitoring actual blocks
# being executed, rather than the specs fudging the timestamps
# with that `allow(Time).to receive(:now).and_return(Time_object)`
# line -- I was using `Time.new` instead of `Time.now`,
# thinking they'd be synonomous.
#
# (Also, oh man, this flashed me back to my years of working
# in science with huge datasets and ten thousand step loops
# and using similar wrappers to try to shave time off my code!
# I'd usually have IDL print the start time, run, then print the 
# end time -- also good for convincing myself that the code was,
# in fact, running. Good times!)
# -------------------------------------------------------

def measure(times = 1, &prc)
  start_time = Time.now

  times.times { prc.call }

  (Time.now - start_time) / times
end

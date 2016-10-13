#!/usr/bin/env ruby
 
require 'coffee-script'
 
# Comppile coffeescript to Javascript and output it to STDOUT. 
# Inputs are one or more coffeescript files on command line, or 
# type coffeescript code on STDIN using Ctrl + d to finish the input, or 
# pass it through pipe
 
if ARGF
  puts CoffeeScript.compile ARGF.read
end

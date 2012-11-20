#!/usr/bin/env ruby

n = ARGV.shift.to_i rescue 1 # TODO rescue better

class Spiralify
  class Field
    def initialize(edge)
      @the_board = [[nil]*edge]*edge # pre-intialize a 2D array to contain the whole thing
    end
  end
  
  def initialize(n = 1)
    @n = n
  end
  
  def spiralize
    [@n]
  end
  
  def print_spiral
    puts "I should be outputting a spiral up to #{@n}"
  end
end

unless n>0
  puts "Please use a positive integer"
end

puts "Input: #{n}"

spiralizer = Spiralify.new(n)

spiralizer.print_spiral
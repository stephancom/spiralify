#!/usr/bin/env ruby

class Spiralify
  # we describe the space of spiraled numbers as a hash of hashes
  # indexed by their displacement from the start position.  
  class Field
    DIRECTIONS = [:right, :up, :left, :down] # counterclockwise
    INITIAL_DIRECTION = :right
    NAVIGATION = {
      right:  {x:  1, y:  0},
      left:   {x: -1, y:  0},
      up:     {x:  0, y:  1},
      down:   {x:  0, y: -1}
    }    
    
    attr_reader :manifold
    
    def initialize(edge)
      @manifold   = {} # store this space as a hash of hashes
      @position   = {x: 0, y: 0} # current position
      @direction  = :right
    end
    
    def is_empty?(position)
      @manifold[position[:x]][position[:y]].nil? rescue true
    end
    
    def self.next_direction(direction)
      DIRECTIONS[(DIRECTIONS.index(direction)+1) % DIRECTIONS.length]
    end
    
    def next_position_for_direction(dir)
      { x: @position[:x] + NAVIGATION[dir][:x],
        y: @position[:y] + NAVIGATION[dir][:y] }
    end
    
    def next_position
      next_position_for_direction(@direction)
    end
    
    def turn_position_is_empty?
      is_empty?(next_position_for_direction(Field.next_direction(@direction)))
    end
    
    def turn
      @direction = Field.next_direction(@direction)
    end
    
    def to_a
      @manifold.keys.sort.map { |y|
        @manifold[y].keys.sort.map { |x|
          @manifold[y][x]
        }
      }
    end

    def next_digit
      turn if turn_position_is_empty?
      @position = next_position
    end
    
    def x
      @position[:x]
    end
    def y
      @position[:y]
    end
  
    def add_digit(d)
      # puts "hi #{d} #{x} #{y}"
      @manifold[x] ||= {}
      @manifold[x][y] = d
      next_digit
    end
  end
  
  def initialize(n = 1)
    @n = n
  end
  
  
  def spiralize
    f = Field.new(Math.sqrt(@n))
    (1..@n).each do |i|
      f.add_digit(i)
    end
    f.to_a
    # f.manifold
  end
  
  def print_spiral
    cols = @n.to_s.length + 1
    spiralize.each do |row|
      puts row.map { |i| "%#{cols}s" % i.to_s }.join
    end
  end

  # extra credit
  # http://stephan.com/blog/seive-of-erastothenes-in-ruby
  def primed_spiral
    primes = [1] + (2..@n).inject((2..@n).to_a) {|res, i| res.select{|n|n==i||n%i!=0} }

    cols = @n.to_s.length + 1
    spiralize.each do |row|
      puts row.map { |i| 
        
        if primes.include?(i)
          "(%#{cols}s)" % i.to_s 
        else
          " %#{cols}s " % i.to_s 
        end
        }.join
    end
  end
end

def spiralize(n)
  unless n>0
    puts "Please use a positive integer"
    return
  end
  
  if Math.sqrt(n) % 1 != 0
    puts "Please use a perfect square"
    return
  end
  
  spiralizer = Spiralify.new(n)

  spiralizer.print_spiral
end

n = ARGV.shift.to_i rescue 1 # TODO rescue better

spiralize(n)

# extra credit
# Spiralify.new(n).primed_spiral
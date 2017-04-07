require_relative 'min_max_stack_queue.rb'
require 'io/console'
require 'benchmark'

def performance_test(size, count)
  arrays_to_test = Array.new(count) { random_arr(size) }

  Benchmark.benchmark(Benchmark::CAPTION, 9, Benchmark::FORMAT,
                      "Avg. Naive:  ", "Avg. Genius: ") do |b|
    naive_cmr = b.report("Tot. Bad:  ") { run_naive_cmr(arrays_to_test) }
    genius_cmr = b.report("Tot. Okay: ") { run_genius_cmr(arrays_to_test) }
    [naive_cmr/count, genius_cmr/count]
  end
end

def self.random_arr(n)
  Array.new(n) { rand(n) }
end

def run_naive_cmr(arrays)
  arrays.each do |array|
    array_to_test = array.dup
    naive_current_max_range(array_to_test, 5)
  end
end

def run_genius_cmr(arrays)
  arrays.each do |array|
    array_to_test = array.dup
    genius_current_max_range(array_to_test, 5)
  end
end

def wait_for_keypress(prompt)
  puts prompt
  STDIN.getch
end

def run_performance_tests(multiplier = 5, rounds = 3)
  [1, 10, 100, 1000, 10000].each do |size|
    size *= multiplier
    wait_for_keypress(
      "Press any key to benchmark sorts for #{size} elements"
    )
    performance_test(size, rounds)
  end
end

def naive_current_max_range(arr, w)
  max_range = nil
  arr.each_cons(w) do |a|
    range = a.max - a.min
    max_range = range if max_range.nil? || max_range < range
  end
  max_range
end

def genius_current_max_range(arr, w)
  max_range = nil
  queue = MinMaxStackQueue.new
  (0...arr.length).each do |i|
    queue.enqueue(arr[i])
    queue.dequeue if queue.size > w
    if queue.size == w
      curr_range = queue.max - queue.min
      max_range = curr_range if max_range.nil? || curr_range > max_range
    end
  end
  max_range
end

puts "naive tests:"
p naive_current_max_range([1, 0, 2, 5, 4, 8], 2) == 4
p naive_current_max_range([1, 0, 2, 5, 4, 8], 3) == 5
p naive_current_max_range([1, 0, 2, 5, 4, 8], 4) == 6
p naive_current_max_range([1, 3, 2, 5, 4, 8], 5) == 6

puts "genius tests:"
p genius_current_max_range([1, 0, 2, 5, 4, 8], 2) == 4
p genius_current_max_range([1, 0, 2, 5, 4, 8], 3) == 5
p genius_current_max_range([1, 0, 2, 5, 4, 8], 4) == 6
p genius_current_max_range([1, 3, 2, 5, 4, 8], 5) == 6

run_performance_tests

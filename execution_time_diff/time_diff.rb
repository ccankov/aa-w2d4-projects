require 'io/console'
require 'benchmark'

def performance_test(size, count)
  arrays_to_test = Array.new(count) { random_arr(size) }

  Benchmark.benchmark(Benchmark::CAPTION, 9, Benchmark::FORMAT,
                      "Avg. Slow:  ", "Avg. Faster: ") do |b|
    slow_min = b.report("Tot. Min Slow:  ") { run_slow_min(arrays_to_test) }
    faster_min = b.report("Tot. Min Faster: ") { run_fast_min(arrays_to_test) }
    lcs_slow = b.report("Tot. LCS Slow: ") { run_slow_lcs(arrays_to_test) }
    lcs_fast = b.report("Tot. LCS Faster: ") { run_fast_lcs(arrays_to_test) }
    [slow_min/count, faster_min/count, lcs_slow/count, lcs_fast/count]
  end
end

def self.random_arr(n)
  Array.new(n) { rand(n) }
end

def run_slow_min(arrays)
  arrays.each do |array|
    array_to_test = array.dup
    my_min_slow(array_to_test)
  end
end

def run_fast_min(arrays)
  arrays.each do |array|
    array_to_test = array.dup
    my_min_faster(array_to_test)
  end
end

def run_slow_lcs(arrays)
  arrays.each do |array|
    array_to_test = array.dup
    largest_contiguous_sum_slow(array_to_test)
  end
end

def run_fast_lcs(arrays)
  arrays.each do |array|
    array_to_test = array.dup
    largest_contiguous_sum_fast(array_to_test)
  end
end

def self.wait_for_keypress(prompt)
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

def my_min_slow(arr)
  arr.each do |val1|
    smallest = true
    arr.each do |val2|
      if val2 < val1
        smallest = false
      end
    end
    return val1 if smallest
  end
end

def my_min_faster(arr)
  smallest = arr.first
  arr.each do |val|
    smallest = val if val < smallest
  end
  smallest
end

def largest_contiguous_sum_slow(arr)
  subs = []
  largest_sum = arr.first
  (1..arr.length).each do |num_el|
    arr.each_cons(num_el) { |subarr| subs << subarr }
  end
  subs.each do |subarr|
    current_sum = subarr.reduce(:+)
    largest_sum = current_sum if current_sum > largest_sum
  end
  largest_sum
end

def largest_contiguous_sum_fast(arr)
  prev_inc = 0
  prev_dec = 0
  curr_inc = 0
  positive = nil
  max_sum = arr.max
  arr.each do |val|
    if curr_inc + val < curr_inc
      if positive && prev_inc + prev_dec + curr_inc > curr_inc
        prev_inc = prev_inc + prev_dec + curr_inc
      elsif positive && prev_inc + prev_dec + curr_inc <= curr_inc
        prev_inc = curr_inc
      elsif !positive
        prev_dec += val
      end
      if positive
        curr_inc = 0
        prev_dec = val
      end
      if positive && prev_inc > max_sum
        max_sum = prev_inc
      end
      positive = false
    else
      positive = true
      curr_inc += val
    end
  end
  if prev_inc + prev_dec + curr_inc > max_sum
    max_sum = prev_inc + prev_dec + curr_inc
  end
  max_sum
end

puts "Tests for my_min_slow:"
list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
p my_min_slow(list) == -5

puts "Tests for my_min_faster:"
list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
p my_min_faster(list) == -5

puts "Tests for largest_contiguous_sum_slow:"
list = [5, 3, -7]
p largest_contiguous_sum_slow(list) == 8
list = [-5, -1, -3]
p largest_contiguous_sum_slow(list) == -1

puts "Tests for largest_contiguous_sum_fast:"
list = [5, 3, -7]
p largest_contiguous_sum_fast(list) == 8
list = [-5, -1, -3]
p largest_contiguous_sum_fast(list) == -1
list = [-1, 2, 2, 2, -100, -1, 2, 2, 2, -4, -1, 5, 2, -10]
p largest_contiguous_sum_fast(list) == 8
list = [-6, 5, 8, 7, -5, -7, 15]
p largest_contiguous_sum_fast(list) == 23

run_performance_tests(1)

require 'io/console'
require 'benchmark'

def performance_test(size, count)
  arrays_to_test = Array.new(count) { random_arr(size) }

  Benchmark.benchmark(Benchmark::CAPTION, 9, Benchmark::FORMAT,
                      "Avg. Bad:  ", "Avg. Okay: ", "Avg. Best") do |b|
    bad_sum = b.report("Tot. Bad:  ") { run_bad_sum(arrays_to_test) }
    okay_sum = b.report("Tot. Okay: ") { run_okay_sum(arrays_to_test) }
    best_sum = b.report("Tot. Best: ") { run_best_sum(arrays_to_test) }
    [bad_sum/count, okay_sum/count, best_sum/count]
  end
end

def self.random_arr(n)
  Array.new(n) { rand(n) }
end

def run_bad_sum(arrays)
  arrays.each do |array|
    array_to_test = array.dup
    bad_two_sum?(array_to_test, 20)
  end
end

def run_okay_sum(arrays)
  arrays.each do |array|
    array_to_test = array.dup
    okay_two_sum?(array_to_test, 62)
  end
end

def run_best_sum(arrays)
  arrays.each do |array|
    array_to_test = array.dup
    best_two_sum?(array_to_test, 70)
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

def bad_two_sum?(arr, target_sum)
  arr.each_with_index do |val1, idx1|
    arr.each_with_index do |val2, idx2|
      next if idx1 == idx2
      return true if val1 + val2 == target_sum
    end
  end
  false
end

def quicksort(arr)
  return arr if arr.length < 2
  pivot = arr.sample
  left = arr.select { |val| val < pivot }
  right = arr.select { |val| val > pivot }
  quicksort(left) + [pivot] + quicksort(right)
end

def binary_search(arr, target)
  return nil if arr.empty?
  midpoint = arr.length/2
  return midpoint if arr[midpoint] == target
  if arr[midpoint] < target
    upper_search = binary_search(arr[midpoint+1...arr.length], target)
    upper_search.nil? ? nil : midpoint + 1 + upper_search
  else
    binary_search(arr[0...midpoint], target)
  end
end

def okay_two_sum?(arr, target_sum)
  sorted = quicksort(arr)
  sorted.each do |val|
    target_val = target_sum - val
    return true if binary_search(arr, target_val) && target_val != val
  end
  false
end

def best_two_sum?(arr, target_sum)
  hashmap = Hash.new(false)
  arr.each do |val|
    hashmap[val] = target_sum - val
  end

  hashmap.values.each do |val|
    return true if hashmap[val] && hashmap[val] != val
  end
  false
end

arr = [0, 1, 5, 7]
p bad_two_sum?(arr, 6) == true
p bad_two_sum?(arr, 10) == false
p okay_two_sum?(arr, 6) == true
p okay_two_sum?(arr, 10) == false
p best_two_sum?(arr, 6) == true
p best_two_sum?(arr, 10) == false

run_performance_tests(1)

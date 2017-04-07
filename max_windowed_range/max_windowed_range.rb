require_relative 'min_max_stack_queue.rb'

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

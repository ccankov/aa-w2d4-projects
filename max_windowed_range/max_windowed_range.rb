def naive_windowed_range(arr, w)
  current_max = nil
  arr.each_cons(w) do |window|
    range = window.max - window.min
    current_max = range if current_max.nil? || range > current_max
  end
  current_max
end

# O(n * w) ?

p naive_windowed_range([1, 0, 2, 5, 4, 8], 2) == 4
p naive_windowed_range([1, 0, 2, 5, 4, 8], 3) == 5
p naive_windowed_range([1, 0, 2, 5, 4, 8], 4) == 6
p naive_windowed_range([1, 3, 2, 5, 4, 8], 5) == 6

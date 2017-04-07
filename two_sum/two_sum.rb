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

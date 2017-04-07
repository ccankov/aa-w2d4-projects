class MyQueue
  def initialize
    @store = []
  end

  def enqueue(el)
    @store.push(el)
  end

  def dequeue
    @store.shift
  end

  def peek
    @store.first
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end
end

class MinMaxStack
  def initialize
    @store = []
  end

  def pop
    @store.pop[:val]
  end

  def push(el)
    cur_min, cur_max = nil
    if @store.empty?
      cur_max = el
      cur_min = el
    else
      cur_max = max < el ? el : max
      cur_min = min > el ? el : min
    end
    val = { val: el, max: cur_max, min: cur_min }
    @store.push(val)
  end

  def peek
    @store.last[:val]
  end

  def min
    @store.last[:min]
  end

  def max
    @store.last[:max]
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end
end

class MinMaxStackQueue
  def initialize
    @inbox = MinMaxStack.new
    @outbox = MinMaxStack.new
  end

  def enqueue(el)
    @inbox.push(el)
  end

  def dequeue
    if @outbox.empty?
      @outbox.push(@inbox.pop) until @inbox.empty?
    end
    @outbox.pop
  end

  def max
    max_arr = []
    max_arr << @inbox.max unless @inbox.empty?
    max_arr << @outbox.max unless @outbox.empty?
    max_arr.max
  end

  def min
    min_arr = []
    min_arr << @inbox.min unless @inbox.empty?
    min_arr << @outbox.min unless @outbox.empty?
    min_arr.min
  end

  def size
    @outbox.size + @inbox.size
  end

  def empty?
    @outbox.empty? && @inbox.empty?
  end
end

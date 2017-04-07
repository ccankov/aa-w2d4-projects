class MyQueue
  def initialize
    @store = []
  end

  def enqueue(val)
    @store.push(val)
  end


  def dequeue
    @store.shift
  end


  def peek
    @store.first
  end

  def size
    @store.size
  end

  def empty?
    @store.empty?
  end
end

class MyStack
  def initialize
    @stack = []
  end

  def pop
    @stack.pop
  end

  def push(val)
    @stack.push(val)
  end

  def peek
    @stack.last
  end

  def size
    @stack.size
  end

  def empty?
    @stack.empty?
  end
end

class StackQueue
  def initialize
    @enqueue = MyStack.new
    @dequeue = MyStack.new
  end

  def enqueue(val)
    @enqueue.push(val)
  end

  def dequeue
    until @enqueue.empty?
      @dequeue.push(@enqueue.pop)
    end
    val = @dequeue.pop
    until @dequeue.empty?
      @enqueue.push(@dequeue.pop)
    end
    val
  end

  def size
    @enqueue.length
  end

  def empty?
    @enqueue.empty?
  end
end

class MinMaxStack
  def initialize
    @stack = []
    @min = []
    @max = []
  end

  def push(val)
    @stack.push(val)
    @max.push(val) if @max.empty? || val > @max.last
    @min.push(val) if @min.empty? || val < @min.last
  end

  def pop
    val = @stack.pop
    @max.pop if val == @max.last
    @min.pop if val == @min.last
  end

  def min
    @min.last
  end

  def max
    @max.last
  end

  def peek
    @stack.last
  end

  def empty?
    @stack.empty?
  end
end

class MinMaxStackQueue
  def initialize
    @enqueue = []
    @dequeue = []
    @max = []
    @min = []
  end

  def enqueue(val)
    @enqueue.push(val)
    @max.push(val) if @max.empty? || val > @max.last
    @min.push(val) if @min.empty? || val < @min.last
  end

  def dequeue
    until @enqueue.empty?
      @dequeue.push(@enqueue.pop)
    end
    val = @dequeue.pop
    until @dequeue.empty?
      @enqueue.push(@dequeue.pop)
    end
    val
  end

  def size
    @enqueue.length
  end

  def empty?
    @enqueue.empty?
  end

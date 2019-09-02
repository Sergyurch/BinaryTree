class Node
  attr_accessor :value, :parent, :child_l, :child_r
  def initialize(value, parent, child_l=nil, child_r=nil)
      @value = value
      @parent = parent
      @child_l = child_l
      @child_r = child_r
  end
  
  def has_children?
    (self.child_l == nil && self.child_r == nil) ? false: true
  end
end

class BinaryTree
  attr_reader :root
  
  def initialize(arr)
    @arr = arr
    @root = nil
  end
  
  def build_tree
    @arr.each do |elem|
      if @root == nil
        @root = Node.new(elem, nil)
      else
        parent = @root
        new_node_created = false
        
        if !parent.has_children?
          if elem < parent.value
            parent.child_l = Node.new(elem, parent)
            new_node_created = true
          else
            parent.child_r = Node.new(elem, parent)
            new_node_created = true
          end
        end
        
        while new_node_created == false do
          if elem < parent.value
            if parent.child_l == nil
              parent.child_l = Node.new(elem, parent)
              new_node_created = true
            else
              parent = parent.child_l
            end
          else
            if parent.child_r == nil
              parent.child_r = Node.new(elem, parent)
              new_node_created = true
            else
              parent = parent.child_r
            end
          end
        end
      end
    end
  end

  def show_tree
    if @root == nil
      puts "The tree is not built"
      return
    end
    
    level = [@root]
    next_level = []
    
    while level != [] do
      level.each do |elem|
        print "#{elem.value} "
        next_level.push(elem.child_l) if elem.child_l != nil
        next_level.push(elem.child_r) if elem.child_r != nil
      end
      puts ""
      level = next_level
      next_level = []
    end
  end
  
  def breadth_first_search(value)
    queue = [@root]
    next_queue = []
    
    while queue != [] do
      queue.each do |elem|
        return elem if value == elem.value
        next_queue.push(elem.child_l) if elem.child_l != nil
        next_queue.push(elem.child_r) if elem.child_r != nil
      end
      queue = next_queue
      next_queue = []
    end
    
    nil
  end
  
  def depth_first_search(value)
    stack = [@root]
    
    while stack != [] do
      return stack[0] if value == stack[0].value
      next_nodes = []
      next_nodes.push(stack[0].child_l) if stack[0].child_l != nil
      next_nodes.push(stack[0].child_r) if stack[0].child_r != nil
      stack.delete_at(0)
      stack = next_nodes + stack if next_nodes != []
    end
    
    nil
  end
  
  def dfs_rec(value, node)
    return node.value if value == node.value
    left_branch_res = dfs_rec(value, node.child_l) if node.child_l != nil
    return left_branch_res if left_branch_res != nil
    right_branch_res = dfs_rec(value, node.child_r) if node.child_r != nil
    return right_branch_res if right_branch_res != nil
    nil
  end
end

tree = BinaryTree.new([5,4,6,3,7,2,8,1,9])


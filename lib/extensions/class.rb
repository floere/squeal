class Class
  
  # Record this or the given classes.
  #
  def squeal &block
    Squeal.record self, &block
  end
  
  # Increments this class' instantiation counter by one.
  #
  def squeal_increment
    Squeal.increment self
  end
  
end
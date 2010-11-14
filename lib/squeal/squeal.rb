class Squeal
  
  module InitializeWrapper
    
    alias_method :initialize_before_squeal, :initialize
    
    def initialize *args, &block
      instance = initialize_before_squeal *args, &block
      self.class.squeal_increment
      instance
    end
    
  end
  
  class << self
    
    # Increment the counter for the given class.
    #
    def increment klass
      return unless @recording && @counters[klass]
      @counters[klass] += 1
    end
    
    # Install and reset for the given class.
    #
    def reset_for klass
      install_on klass
      @counters ||= {}
      @counters[klass] ||= 0
      self
    end
    
    # Installs squeal on the given class if it isn't yet installed.
    #
    def install_on klass
      klass.send :include, InitializeWrapper unless klass.include?(InitializeWrapper)
    end
    
    # Record the given classes for the duration of the block.
    #
    def record *klasses
      @recording = true
      klasses.each { |klass| reset_for klass }
      if block_given?
        yield
        stop
      end
      self
    end
    alias squeal record
    
    # Stop recording.
    #
    def stop
      @recording = false
    end
    
    # Returns a string with the current instantiation count.
    #
    # Example:
    # * SomeClass: 2, SomeOtherClass: 10
    #
    def report
      result = []
      @counters.each_pair do |klass, number|
        result << "#{klass}: #{number}"
      end
      result.sort.join(', ')
    end
    
    # Resets the counters.
    #
    def reset
      @counters = {}
    end
  end
  
end
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
    # Record the given classes.
    #
    def squeal klass, *klasses, &block
      record klass, *klasses, &block
    end
    
    def increment klass
      return unless @recording && @counters[klass]
      @counters[klass] += 1
    end
    
    def reset_for klass
      install_on klass
      @counters ||= {}
      @counters[klass] ||= 0
      self
    end
    
    def install_on klass
      klass.send :include, InitializeWrapper unless klass.include?(InitializeWrapper)
    end
    
    def record *klasses
      @recording = true
      if block_given?
        reset
        klasses.each { |klass| reset_for klass }
        yield
        stop
      end
      self
    end
    def stop
      @recording = false
    end
    def report
      result = []
      @counters.each_pair do |klass, number|
        result << "#{klass}: #{number}"
      end
      result.sort.join(', ')
    end
    def reset
      @counters = {}
    end
  end
  
end
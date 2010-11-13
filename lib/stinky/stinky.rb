class Stinky
  
  module InitializeWrapper
    
    alias_method :initialize_before_stinky, :initialize
    
    def initialize *args, &block
      instance = initialize_before_stinky *args, &block
      self.class.stinky.increment self.class
      instance
    end
    
  end
  
  def initialize target_class = nil
    @record = { target_class => 0 }
    install_on target_class if target_class
  end
  
  def install_on target_class
    target_class.send :include, InitializeWrapper
    
    # class << self
    #   alias_method :allocate_before_oink, :allocate
    # 
    #   def allocate
    #     value = allocate_before_oink
    #     increment_instance_type_count
    #     value
    #   end
    # end
  end
  
  def increment klass
    return unless @recording
    @record[klass] += 1
  end
  
  def record
    
    @recording = true
  end
  def stop
    @recording = false
    
  end
  def report
    result = []
    @record.each_pair do |klass, number|
      result << "#{klass}: #{number}"
    end
    result.sort.join(', ')
  end
  
  def self.record
    unless @global
      @global = new
      @global.install_on Class # TODO metaclass
    end
    @global.record
    yield
    @global.stop
  end
  def self.report
    @global.report
  end
  
end
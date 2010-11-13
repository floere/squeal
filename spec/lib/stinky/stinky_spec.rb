require 'spec_helper'

describe Stinky do
  before(:each) do
    TestClass = Class.new
  end
  
  it 'allows a proxy object' do
    lambda { TestClass.stinky }.should_not raise_error
  end
  it 'records locally' do
    TestClass.stinky.record
    TestClass.new
    TestClass.new
    TestClass.stinky.stop
    TestClass.new
    
    TestClass.stinky.report.should == 'TestClass: 2'
  end
  it 'records locally' do
    TestClass.stinky.record
    TestClass.new
    TestClass.new
    Object.new
    String.new
    TestClass.stinky.stop
    TestClass.new
    
    TestClass.stinky.report.should == 'TestClass: 2'
  end
  it 'records globally' do
    Stinky.record do
      TestClass.new
      TestClass.new
    end
    TestClass.new
    
    Stinky.report.should == 'TestClass: 2'
  end
  it 'does not record if stinky.record has not been called' do
    TestClass.new
    TestClass.new
    
    TestClass.stinky.report.should == 'TestClass: 0'
  end
  it 'reports globally' do
    Stinky.record do
      TestClass.new
      Object.new
    end
    
    Stinky.report.should == 'Object: 1, TestClass: 1'
  end

end
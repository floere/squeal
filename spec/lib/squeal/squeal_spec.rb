require 'spec_helper'

describe Squeal do
  before(:each) do
    Object.send :remove_const, :TestClass if Object.const_defined?(:TestClass)
    TestClass = Class.new
  end
  after(:each) do
    Squeal.reset
  end
  it 'allows a proxy object' do
    lambda { TestClass.squeal }.should_not raise_error
  end
  it 'records with a block' do
    TestClass.squeal do
      TestClass.new
      TestClass.new
      Object.new
      String.new
    end
    TestClass.new
    
    Squeal.report.should == 'TestClass: 2'
  end
  it 'records all mentioned classes with a block' do
    Squeal.squeal(Object, TestClass) do
      TestClass.new
      String.new
      Object.new
      TestClass.new
      String.new
    end
    Object.new
    TestClass.new
    
    Squeal.report.should == 'Object: 1, TestClass: 2'
  end
  it 'records the class it is used on with a block' do
    TestClass.squeal do
      TestClass.new
      Hash.new
      TestClass.new
      Object.new
      Hash.new
    end
    TestClass.new
    
    Squeal.report.should == 'TestClass: 2'
  end
  it 'does not record if squeal.record has not been called' do
    Hash.new
    TestClass.new
    
    Squeal.report.should == ''
  end

end
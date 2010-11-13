require 'rubygems'
require 'spec'

require File.expand_path '../../lib/stinky.rb', __FILE__

class PseudoOutput < Array
  
  def puts(line)
    self << line
  end
  
end
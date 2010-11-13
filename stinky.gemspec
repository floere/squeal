Gem::Specification.new do |s|
  s.name = "stinky"
  s.version = "1.0.0"
  s.authors = ["Florian Hanke"]
  s.date = "2010-11-13"
  s.description = "Object instantiation recorder."
  s.email = "florian.hanke+stinky@gmail.com"
  s.extra_rdoc_files = ["README.textile"]
  s.files = Dir["lib/**/*.rb"]
  s.homepage = "http://github.com/floere/stinky"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.3.7"
  s.summary = "Records object instantiations."
  s.test_files = Dir["spec/lib/**/*_spec.rb"]
end


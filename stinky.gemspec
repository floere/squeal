Gem::Specification.new do |s|
  s.name = "stinky"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
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
  s.test_files = [
    "spec/oink/active_record_instantiation_reporter_spec.rb",
     "spec/oink/memory_usage_reporter_spec.rb",
     "spec/oinked_request/oinked_request_spec.rb",
     "spec/priority_queue/priority_queue_spec.rb",
     "spec/rails/instance_type_counter_spec.rb",
     "spec/rails/memory_usage_logger_spec.rb",
     "spec/spec_helper.rb"
  ]
end


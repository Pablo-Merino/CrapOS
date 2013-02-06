$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
name = "crap_os"
require "#{name}/version"

Gem::Specification.new name, CrapOS::VERSION do |s|
	s.summary = "A crap and not real OS in ruby"
	s.authors = ["Pablo Merino"]
	s.email = "pablo@wearemocha.com"
	s.homepage = "http://github.com/pablo-merino/#{name}"
	s.files = `git ls-files`.split("\n")
	s.license = "MIT"
	s.add_dependency('active_support', ['~> 3.0.0'])
end

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "noodall_poll/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "noodall_poll"
  s.version     = NoodallPoll::VERSION
  s.authors     = ["Rob Nichols"]
  s.email       = ["hello@wearebeef.co.uk"]
  s.homepage    = "http://wearebeef.co.uk"
  s.summary     = "Provides a polling facility to Noodall sites"
  s.description = "Provides the tools for an administrator to add a poll to pages within their noodall application."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.0"
  s.add_dependency "mongo_mapper"
  s.add_dependency "bson_ext"

end

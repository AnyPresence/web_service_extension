$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "web_service_extension/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "web_service_extension"
  s.version     = WebServiceExtension::VERSION
  s.authors     = ["Anypresence"]
  s.email       = ["info@anypresence.com"]
  s.homepage    = "http://www.anypresence.com/"
  s.summary     = ""
  s.description = "WebServiceExtension"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc", "manifest.json"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency "mongoid", "~> 3.0.6"
  s.add_dependency "savon"
  s.add_dependency "faraday", '~> 0.8.4'

  s.add_development_dependency "shoulda", "~> 3.0.1"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "factory_girl", "= 3.3.0"
  s.add_development_dependency "mocha", "~> 0.12.3"
  s.add_development_dependency "debugger"
  s.add_development_dependency "webmock"
  s.add_development_dependency "vcr"
end

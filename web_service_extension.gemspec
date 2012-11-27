$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "web_service_extension/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "web_service_extension"
  s.version     = WebServiceExtension::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of WebServiceExtension."
  s.description = "TODO: Description of WebServiceExtension."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency "mongoid", "~> 3.0.6"
  s.add_dependency "savon"
  s.add_dependency "faraday"

  s.add_development_dependency "shoulda"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "factory_girl", "= 3.3.0"
  s.add_development_dependency "debugger"
  s.add_development_dependency "webmock"
  s.add_development_dependency "vcr"
end

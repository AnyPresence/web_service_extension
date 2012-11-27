# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require 'database_cleaner'
require 'factory_girl'
require 'shoulda'
require 'webmock/test_unit'
require 'vcr'

Rails.backtrace_cleaner.remove_silencers!

Dir.glob(File.dirname(__FILE__) + "/factories/*").each do |factory|
  require factory
end

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

DatabaseCleaner.orm = "mongoid"
DatabaseCleaner.strategy = :truncation

# Load fixtures from the engine
#if ActiveSupport::TestCase.method_defined?(:fixture_path=)
#  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
#end

#class ActiveSupport::TestCase
#  fixtures :all
#end

VCR.config do |c|
  c.stub_with :webmock
  c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  c.allow_http_connections_when_no_cassette = true
  c.default_cassette_options = { :record => :new_episodes }
end

class Test::Unit::TestCase
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end

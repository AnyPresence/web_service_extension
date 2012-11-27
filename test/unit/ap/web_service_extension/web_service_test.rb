require 'test_helper'

class WebServiceExtension::WebServiceTest < Test::Unit::TestCase
  
  should "know how to configure account" do
    ::AP::WebServiceExtension::WebService.config_account({:key0 => "val0"})
    
    config = ::AP::WebServiceExtension::WebService.class_variable_get(:@@config)
    assert_equal("val0", config[:key0])
  end
  
end

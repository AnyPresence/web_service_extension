require 'test_helper'

class WebServiceExtension::WebServiceTest < Test::Unit::TestCase

  should "know how to configure account" do
    ::AP::WebServiceExtension::WebService.config_account({:key0 => "val0"})

    config = ::AP::WebServiceExtension::WebService.class_variable_get(:@@config)
    assert_equal("val0", config[:key0])
  end

  should "know how to connect to WSDL endpoint" do
    ENV['AP_WEB_SERVICE_NOTIFIER_ENDPOINT'] = "http://192.168.1.3:8080/Meep/Meep?WSDL"
    AP::WebServiceExtension::WebService::config_account()
    outage = Outage.new
    response = mock('response')
    response.expects(:body)
    Savon::Client.any_instance.stubs(:request).returns(response)
    VCR.use_cassette('test_wsdl_response') do
      outage.save
    end
  end

  should "know how to make post request" do
    ENV['AP_WEB_SERVICE_NOTIFIER_ENDPOINT'] = "http://localhost:3001/secrets"
    AP::WebServiceExtension::WebService::config_account()
    outage = Outage.new
    AP::WebServiceExtension::HttpUtility.any_instance.expects(:post).once
    VCR.use_cassette('test_post_response') do
      outage.save
    end
  end

end

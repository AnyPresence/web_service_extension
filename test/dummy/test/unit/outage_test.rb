require 'test_helper'

class OutageTest < Test::Unit::TestCase

  should "not perform web service action when disabled" do
    AP::WebServiceExtension::WebService::config_account(disabled: true)
    outage = Outage.new
    Savon.expects(:new).never
    ::AP::WebServiceExtension::HttpUtility.expects(:new).never
    outage.save
    AP::WebServiceExtension::WebService::config_account(disabled: false)
  end
end

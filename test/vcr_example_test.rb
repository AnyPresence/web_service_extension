require 'test_helper'

class VCRExampleTest < Test::Unit::TestCase
  def test_use_vcr
    VCR.use_cassette('test_wsdl_response') do
      response = Net::HTTP.get_response('192.168.1.3', '/Meep/Meep?WSDL', 8080)
      assert_match /<service name="Meep">/, response.body
    end
  end
end
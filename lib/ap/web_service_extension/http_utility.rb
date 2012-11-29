require 'faraday'

module AP
  module WebServiceExtension
    class HttpUtility
      attr_reader :http_connection
      
      def initialize(endpoint)
        @endpoint = endpoint
      end
      
      def setup_connection
        connection({:user_agent => "Anypresence Extension"})
      end
      
      def post(uri, params=nil)
        @http_connection.post(uri, params)
      end
      
      def connection(options={})
        default_options = {
          :headers => {
            :accept => 'application/json',
            :user_agent => options[:user_agent],
          },
          :proxy => options[:proxy],
          :ssl => {:verify => false},
          :url => options.fetch(:endpoint, options[:endpoint]),
        }
        @http_connection ||= Faraday.new(default_options) do |builder|
          builder.use Faraday::Request::UrlEncoded  # convert request params as "www-form-urlencoded"
          builder.use Faraday::Response::Logger     # log the request to STDOUT
          builder.use Faraday::Adapter::NetHttp     # make http requests with Net::HTTP
          builder.adapter(:net_http)
        end
      end
    end
  end
end
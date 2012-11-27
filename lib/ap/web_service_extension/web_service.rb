require "savon"

module AP
  module WebServiceExtension
    module WebService
      include ::WebServiceExtension::Common
      
      @@config = HashWithIndifferentAccess.new
      
      # Creates the account.
      # +config+ configuration properties should contain
      def self.config_account(config={})
        if config.empty?
          raise "Nothing to configure!"
        end
        config = HashWithIndifferentAccess.new(config)
        
        @@config.merge!(config)
      end
      
      # Builds request for webservice.
      #  +object_instance+ is the object instance
      #  +options+ is a hash that includes: +endpoint+ the endpoint to connect to, +action+ soap action
      def web_service_perform(object_instance, options={})
        if options[:endpoint].blank?
          Rails.logger.error "Unable to perform action."
          return
        end
        endpoint = options[:endpoint]
        
        # Check if endpoint is to WSDL
        if endpoint.downcase.end_with?("wsdl")
          # Uses soap client
          client = soap_client(endpoint) 
          
          return if options[:action].blank?
          
          response = client.request(options[:action].to_sym) do
            soap.body = object_instance.attributes
          end
          
          return response.body
        else
          setup_connection
          # Check if basic auth is required
          @http_connection.basic_auth(options[:username], options[:password]) if (!options[:username].blank? && !options[:password].blank?)
          response = post(endpoint, object_instance.attributes)
          return response
        end
      end
      
protected
      def basic_auth_encode_cred(username, password)
        "Basic " + Base64::encode64("#{username}:#{password}")
      end
      
      def soap_client(endpoint)
        Savon.client(endpoint)
      end
      
      def post(uri, params=nil)
        @http_connection.post(uri, params)
      end
      
      def setup_connection
        connection({:user_agent => "Anypresence Extension"})
      end
      
      # Connect to API.
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

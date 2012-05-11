require 'multi_json'
require 'timeout'
require 'rest_client'
require 'delegate'

module SmokeyBear
  module Helpers

    class ResponseDelegate < DelegateClass(RestClient::Response)

      def has_status?(expected_code)
        code == expected_code
      end

      def json?
        headers[:content_type] =~ /\bjson\b/
      end

    end

    def get(*args);    perform_request(:get, *args); end
    def post(*args);   perform_request(:post, *args); end
    def delete(*args); perform_request(:delete, *args); end
    def put(*args);    perform_request(:put, *args); end
    def head(*args);   perform_request(:head, *args); end

    def response
      @response ||= (raise "Please make sure you perform a request first")
    end

    def decoded_response
      @decoded_response ||= MultiJson.load(response.to_str)
    end

    def headers
      response.headers
    end

    private

    def perform_request(*args)
      Timeout.timeout SmokeyBear.timeout do
        perform_raw_request(*args)
      end
    end

    def perform_raw_request(method, path, options = {})
      url = File.join(SmokeyBear.base_url)
      endpoint   = options.delete(:endpoint)
      endpoint ||= SmokeyBear.endpoint unless endpoint == false
      url = File.join(url, endpoint) unless endpoint == false
      url = File.join(url, path)
      if [:post, :put, :delete].include?(method)
        response = RestClient.send method, url, MultiJson.dump(options), :content_type => :json, :accept => :json
      else
        url << "?#{options.to_param}" unless options.empty?
        response = RestClient.send method, url, :accept => :json
      end
      @response = ResponseDelegate.new response
    rescue RestClient::Exception => e
      @response = e.response
    end

  end
end
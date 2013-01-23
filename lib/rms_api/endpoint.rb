require 'net/https'
require 'json'

module RMSAPI
  class Endpoint
    attr_reader :config

    def initialize(options = {})
      @config = options[:config] || RMSAPI.configuration
      @xml = options[:xml]
    end

    def lookup
      xml? ? body : JSON(body || not_found)['ROWSET']['ROW']
    end

    def body
      @body ||= get_response_body
    end

    def xml?
      !@xml.nil?
    end

    def full_path
      "#{config.path_prefix}#{command}#{params}"
    end

    def full_url
      "https://#{config.host}#{full_path}"
    end

    def params
      [auth_key_param, format_param, lookup_params].compact.join("&")
    end

    def format_param
      xml? ? "p_format=xml" : nil
    end

    def auth_key_param
      "p_auth_key=#{config.auth_key}"
    end

    def command
      raise "This method must be defined within the Endpoint subclass."
    end

    def lookup_params
      raise "This method must be defined within the Endpoint subclass."
    end

    private

    def get_response_body
      http = ::Net::HTTP.new(config.host, 443)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE unless config.ssl_verify?
      response = http.get(full_path)
      return nil if response.code == '404'
      response.body
    end

    def not_found
      %q({"ROWSET" : {"ROW" : {}}})
    end
  end
end

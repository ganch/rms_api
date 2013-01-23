require 'rms_api/endpoint'

module RMSAPI
  class Endpoint
    class Event < Endpoint
      attr_reader :start_range, :end_range, :return_format

      def initialize(options = {})
        super
        @start_range = options[:start_range]
        @end_range = options[:end_range]
        @return_format = options[:return_format]
      end

      def command
        "get_events?"
      end

      def lookup_params
        lookup_parameters = ""
        lookup_parameters += "p_range_start=#{start_range}&" unless start_range.nil?
        lookup_parameters += "p_range_end=#{end_range}&" unless end_range.nil?
        lookup_parameters += "p_format=#{return_format}" unless return_format.nil?
        lookup_parameters.empty? ? nil : lookup_parameters
      end
    end
  end
end

module RMSAPI
  class Response
    def initialize(options = {})
      @options = options
    end

    def render_json
      erb = ERB.new(RMSAPI::Response.const_get("#{json_type}_JSON"))
      erb.result(binding())
    end

    def json_type
      @options[:type].to_s.upcase
    end

    private

    def method_missing(method_id)
      @options.fetch(method_id.to_sym, '')
    end

    EVENT_JSON = <<END
{
  "ROWSET" : {
    "ROW" : {
      "EVENT_ID" : "<%= rms_id %>",
      "START_TIME" : "<%= start_time %>",
      "END_TIME" : "<%= end_time %>",
      "EVENT_TITLE" : "<%= title %>",
      "LOCATION" : "<%= location %>",
      "CONTACT_NAME" : "<%= contact_name %>"
    }
  }}
END

  end
end

require 'rms_api/endpoint/event'

module RMSAPI

  # Returns RMSAPI::Event objects, with accessors for :rms_id, :start_time,
  # :location, and :contact_name.
  def self.lookup_events(start_range, end_range, return_format)
    options = {:start_range => start_range, :end_range => end_range, :return_format => return_format, :config => self.configuration}
    events = RMSAPI::Endpoint::Event.new(options)
    return_value = []
    events_returned = events.lookup
    if events_returned.kind_of?(Array)
      events.lookup.each do |event|
        return_value << RMSAPI::Event.new(event)
      end
    else
      return_value << RMSAPI::Event.new(events_returned)
    end
    return_value
  end

  class Event
    attr_reader :rms_id, :start_time, :end_time, :title, :location, :contact_name

    def initialize(row)
      @rms_id = row['EVENT_ID']
      @start_time = row['START_TIME']
      @end_time = row['END_TIME']
      @title = row['EVENT_TITLE']
      @location = row['LOCATION']
      @contact_name = row['CONTACT_NAME']
    end

    def self.from_rows(*rows)
      rows.flatten.map { |row| self.new(row) }
    end

  end
end

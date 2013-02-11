require 'spec_helper'

describe RMSAPI::Response do
  subject { RMSAPI::Response.new(options) }

  context "with options for an Event lookup" do
    let(:event_id) { '2012-AAXKVA201301081900@r25.dartmouth.edu' }
    let(:start_time) { '2013-JAN-08 19:01' }
    let(:end_time) { '2013-JAN-08 20:00' }
    let(:title) { 'Good Movie'}
    let(:location) { 'Hopkins Center Moore Theater' }
    let(:contact_name) { "Hopkins Center Box Office" }

    let(:options) { {:type => :event, :event_id => event_id, :start_time => start_time, :end_time => end_time, :title => title, :location => location,
                    :contact_name => contact_name} }

    it "has the correct JSON type" do
      subject.json_type.should == 'EVENT'
    end

    it "returns the correct values" do
      subject.event_id.should == event_id
      subject.start_time.should == start_time
      subject.end_time.should == end_time
      subject.title.should == title
      subject.location.should == location
      subject.contact_name == contact_name
    end

    it "renders the correct JSON text" do
      subject.render_json.should match(/"START_TIME" : "#{start_time}"/)
    end
  end
end

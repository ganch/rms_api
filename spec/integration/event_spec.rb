require 'spec_helper'
require 'rms_api'

describe RMSAPI do

  describe "WHEN: all search parameters are utilized to find a single record" do
    # Use attributes of a known event.
    let(:start_range) { '2012-JAN-04' }
    let(:end_range) { '2012-JAN-05' }
    let(:return_format) { "JSON" }

    subject { RMSAPI.lookup_events(start_range, end_range, return_format) }

    it "should return an array containing one record" do
      subject.count.should == 1
    end

    it "should contain the details of the event we were expecting" do
      subject.first.rms_id.should eq "2011-AAWNOG201201041900@r25.dartmouth.edu"
      subject.first.start_time.should eq "2012-JAN-04 19:01"
      subject.first.location.should eq "Hopkins Center Spaulding Auditorium"
      subject.first.contact_name.should eq "Hopkins Center Box Office" 
    end
  end

  describe "WHEN: only two of the search parameters are utilized and more than one record is returned" do
    # Use attributes of a known event.
    let(:start_range) { '2012-JAN-04' }
    let(:return_format) { "JSON" }

    subject { RMSAPI.lookup_events(start_range, nil, return_format) }
    
    it "should return an array containing more than one record" do
      subject.count.should > 1
    end

    it "should contain the details of the event we were expecting as the first item in the array" do
      subject.first.rms_id.should eq "2011-AAWNOG201201041900@r25.dartmouth.edu"
      subject.first.start_time.should eq "2012-JAN-04 19:01"
      subject.first.location.should eq "Hopkins Center Spaulding Auditorium"
      subject.first.contact_name.should eq "Hopkins Center Box Office" 
    end
  end
end

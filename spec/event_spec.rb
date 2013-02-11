require 'spec_helper'
require 'rms_api/event'

describe RMSAPI::Event do
  describe "#new" do
    let(:row) { { 'EVENT_ID' => '2012-AAXKVA201301081900@r25.dartmouth.edu', 'START_TIME' => "2012-DEC-25 19:01", 'END_TIME' => "2012-DEC-25 20:00",
                  'EVENT_TITLE' => 'Christmas Revels', 'LOCATION' =>'Moore Theater', 'CONTACT_NAME' => 'Box Office'} }

    subject { RMSAPI::Event.new(row) }

    context "parsing Event" do
      its(:rms_id) { should == '2012-AAXKVA201301081900@r25.dartmouth.edu' }
      its(:start_time) { should == '2012-DEC-25 19:01' }
      its(:end_time) { should == '2012-DEC-25 20:00' }
      its(:title) { should == 'Christmas Revels' }
      its(:location) { should == 'Moore Theater' }
      its(:contact_name) { should == 'Box Office' }
    end
  end

end

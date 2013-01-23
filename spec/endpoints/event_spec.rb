require 'spec_helper'
require 'rms_api/configuration'
require 'rms_api/endpoint/event'

describe RMSAPI::Endpoint::Event do
  describe "#new" do
    let(:auth_key) { 'authkey' }
    let(:config) { stub(:url_prefix => '', :auth_key => auth_key) }
    let(:options) { {:config => config, :start_range => start_range, :end_range => end_range, :return_format => return_format } }

    subject { RMSAPI::Endpoint::Event.new(options) }

    context "with supplied :start_range, :end_range, and :format options" do
      let(:start_range) { '2013-JAN-29' }
      let(:end_range) { '2013-JAN-31' }
      let(:return_format) { 'JSON' }

      it "should have the correct lookup parameters" do
        subject.lookup_params.should == "p_range_start=#{start_range}&p_range_end=#{end_range}&p_format=#{return_format}"
      end
    end

    context "without any supplied options" do
      let(:start_range) { nil }
      let(:end_range) { nil }
      let(:return_format) { nil }

      it "should have an empty lookup parameter" do
        subject.lookup_params.should be_nil
      end
    end
  end
end

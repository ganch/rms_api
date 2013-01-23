require 'spec_helper'
require 'rms_api/endpoint'

describe RMSAPI::Endpoint do
  describe "#new" do
    let(:config) { stub(:url_prefix => '', :auth_key => 'authkey') }
    let(:options) { {:config => config} }

    subject { RMSAPI::Endpoint.new(options) }

    context "with only a config object" do
      it "should not be in XML format" do
        subject.should_not be_xml
      end

      it "should have no format parameter" do
        subject.format_param.should be_nil
      end

      it "should return the correct auth_key parameter" do
        subject.auth_key_param.should == 'p_auth_key=authkey'
      end
    end

    context "with a config object and XML formatting" do
      before { options.merge!(:xml => true) }

      it "should be in XML format" do
        subject.should be_xml
      end

      it "should have the XML format parameter" do
        subject.format_param.should == 'p_format=xml'
      end
    end
  end
end

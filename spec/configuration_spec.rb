require 'spec_helper'
require 'rms_api/configuration'

describe RMSAPI::Configuration do
  let(:env_cache) { {} }
  let(:env) { 'rms_api' }
  let(:dir) { File.expand_path("../../tmp", __FILE__) }
  let(:config) { RMSAPI::Configuration.new }

  describe "#env" do

    it "should be the value of ENV['RMS_API_ENV'], when specified" do
      set_env('RMS_API_ENV', env)
      config.env.should == env.to_sym
      restore_env('RMS_API_ENV')
    end

    it "should be the value of ENV['RAILS_ENV'], when it's specified and RMS_API_ENV isn't" do
      set_env('RAILS_ENV', env)
      set_env('RMS_API_ENV', nil)
      config.env.should == env.to_sym
      restore_env('RAILS_ENV')
    end

    it "should be the value of ENV['RACK_ENV'], when other ENV values aren't specified" do
      set_env('RACK_ENV', env)
      set_env('RMS_API_ENV', nil)
      config.env.should == env.to_sym
      restore_env('RAILS_ENV')
      restore_env('RACK_ENV')
    end

    it "should be the value of the :env option, when supplied in the call to .new" do
      config = RMSAPI::Configuration.new(:env => env)
      config.env.should == env.to_sym
    end
  end

  describe "#auth_file_path" do
    it "should point to the current user's home directory, if :home_dir not specified" do
      config.auth_file_path.should == File.expand_path("#{ENV['HOME']}/.rms_api_auth_key")
    end

    it "should point into the supplied :home_dir directory" do
      config = RMSAPI::Configuration.new(:home_dir => dir)
      config.auth_file_path.should == "#{dir}/.rms_api_auth_key"
    end
  end

  describe "#auth_key" do
    let(:auth_key) { 'rms_api_auth_key' }

    it "should be the value of ENV['RMS_API_AUTH_KEY'], when specified" do
      set_env('RMS_API_AUTH_KEY', auth_key)
      config.auth_key.should == auth_key
      restore_env('RMS_API_AUTH_KEY')
    end

    it "should be the value of the :auth_key option, when supplied" do
      config = RMSAPI::Configuration.new(:auth_key => auth_key)
      config.auth_key.should == auth_key
    end

    context "from a .rms_api_auth_key file" do
      let(:config) { RMSAPI::Configuration.new(:home_dir => dir) }

      it "should return the auth_key from the .rms_api_auth_key file" do
        write_auth_key_file(config.auth_file_path, auth_key)
        config.auth_key.should == auth_key
        clear_auth_key_file(config.auth_file_path)
      end

      it "should raise an error when the .rms_api_auth_key file is not found" do
        error = "Missing '.rms_api_auth_key' file in #{dir}."
        lambda { config.auth_key }.should raise_error(error)
      end
    end
  end
end

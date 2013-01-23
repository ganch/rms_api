require 'rspec'
require 'support/rms_api_helpers'

ENV["RMS_API_ENV"] ||= 'test'

RSpec.configure do |config|
  config.include(RMSAPIHelpers)
end

require 'lib/rms_api'
require 'lib/rms_api/response'
require 'fileutils'

module RMSAPIHelpers
  def set_env(key, value)
    env_cache[key] = ENV[key]
    ENV[key] = value
  end

  def restore_env(key)
    ENV[key] = env_cache[key]
  end

  def write_auth_key_file(path, key)
    File.open(path, 'w') { |f| f << key }
  end

  def clear_auth_key_file(path)
    FileUtils.rm(path, :force => true)
  end

  def render_lookup_json(options = {})
    RMSAPI::Response.new(options).render_json
  end

  def fake_lookup_url(options, json_text)
    options.merge!(:config => RMSAPI.configuration)
    klass = RMSAPI::Endpoint.const_get(options[:type].to_s.titleize)
    lookup = klass.new(options)
    FakeWeb.register_uri(:get, lookup.full_url, :body => json_text)
  end

  def env_cache
    @env_cache ||= {}
  end
end

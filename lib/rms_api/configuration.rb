module RMSAPI

  def self.configuration
    @configuration ||= RMSAPI::Configuration.new
  end

  def self.configure
    yield configuration if block_given?
  end

  class Configuration
    def initialize(options = {})
      self.env = options[:env]
      self.auth_key = options[:auth_key]
      @home_dir = options[:home_dir]
    end

    def env=(value)
      @env = value.nil? ? nil : value.to_sym
    end

    def env
      @env ||= (lookup_env || :development).to_sym
    end

    def ssl_verify?
      ! (env == :test || :development)
    end

    def auth_key=(key)
      @auth_key = key
    end

    def auth_key
      @auth_key || ENV['RMS_API_AUTH_KEY'] || read_auth_key
    end

    def home_dir
      @home_dir ||= File.expand_path("~#{ENV['USER']}")
    end

    def auth_file_path
      @auth_file_path = File.join(home_dir, auth_file_name)
    end

    def host
      env_urls[env][:host]
    end

    def path_prefix
      env_urls[env][:path_prefix]
    end

    private

    def lookup_env
      ENV['RMS_API_ENV'] || ENV['RAILS_ENV'] || ENV['RACK_ENV']
    end

    def read_auth_key
      missing_auth_key_file unless File.file?(auth_file_path)
      key = IO.readlines(auth_file_path)[0] # first line must be the key
      key.chomp.strip
    end

    def missing_auth_key_file
      raise "Missing '#{auth_file_name}' file in #{home_dir}."
    end

    def auth_file_name
      '.rms_api_auth_key'
    end

    def env_urls
      { :development  => {  :host         => 'tower-dev.dartmouth.edu',
                            :path_prefix  => '/dart/harpo/dc_rms.' },
        :test         => {  :host         => 'tower-dev.dartmouth.edu',
                            :path_prefix  => '/dart/harpo/dc_rms.' },
        :staging      => {  :host         => 'tower-dev.dartmouth.edu',
                            :path_prefix  => '/dart/chico/dc_rms.' },
        :production   => {  :host         => 'tower.dartmouth.edu',
                            :path_prefix  => '/dart/groucho/dc_rms.' }
        }
    end
  end
end

require 'bundler/setup'
require 'webmock/rspec'
require 'dotenv'

Dotenv.load '.env'

WebMock.disable_net_connect!(:allow_localhost => true)

load 'yuncli'

require 'vcr'
VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr"
  config.hook_into :webmock # or :fakeweb
  config.default_cassette_options = { :record => :new_episodes }
  config.configure_rspec_metadata!
  config.allow_http_connections_when_no_cassette = true
end

RSpec.configure do |conf|
  def fixture(fn)
    "spec/fixtures/#{fn}"
  end
end

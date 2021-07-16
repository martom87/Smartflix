# frozen_string_literal: true

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.ignore_localhost = true
  config.filter_sensitive_data('apikey') { Rails.application.credentials[Rails.env.to_sym][:omdb][:access_key_id] }
  config.ignore_localhost = true
end

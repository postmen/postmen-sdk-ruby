require 'bundler/setup'
require File.expand_path(File.join(File.dirname(__FILE__), '../lib/postmen'))
require 'webmock/rspec'

Bundler.setup

RSpec.configure do |config|
end

def responses(key, type)
  File.read(Postmen.root.join('spec', 'support', key, "#{type}.json"))
end

def stub_labels_request!
  stub_request(:get, "https://sandbox-api.postmen.com/v3/labels")
    .with(headers: {"postmen-api-key": "CORRECT_KEY"})
    .to_return(body: responses("labels", "success"), headers: {"Content-Type" => "application/json; charset=utf-8"})

  stub_request(:get, "https://sandbox-api.postmen.com/v3/labels")
    .with(headers: {"postmen-api-key": "CORRECT_KEY_NO_LABELS"})
    .to_return(body: responses("labels", "empty"), headers: {"Content-Type" => "application/json; charset=utf-8"})
end

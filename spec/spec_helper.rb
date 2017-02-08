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
  stub_request(:get, 'https://sandbox-api.postmen.com/v3/labels')
    .with(headers: { "postmen-api-key": 'CORRECT_KEY' })
    .to_return(body: responses('labels', 'success'),
               headers: { 'Content-Type' => 'application/json; charset=utf-8' })

  stub_request(:get, 'https://sandbox-api.postmen.com/v3/labels')
    .with(headers: { "postmen-api-key": 'CORRECT_KEY_NO_LABELS' })
    .to_return(body: responses('labels', 'empty'),
               headers: { 'Content-Type' => 'application/json; charset=utf-8' })
end

def stub_rate_limit_exceeded_request!
  stub_request(:get, 'https://sandbox-api.postmen.com/v3/labels')
    .to_return(status: 429, body: responses('general', 'rate_limit_exceeded'))
end

def stub_label_request!
  stub_request(:get, 'https://sandbox-api.postmen.com/v3/labels/00000000-0000-0000-0000-000000000000')
    .to_return(body: responses('labels', 'single_error'),
               headers: { 'Content-Type' => 'application/json; charset=utf-8' })

  stub_request(:get, 'https://sandbox-api.postmen.com/v3/labels/ee1af83b-6aa9-40ad-b60f-3b7a17cf78ce')
    .to_return(body: responses('labels', 'single_existing'),
               headers: { 'Content-Type' => 'application/json; charset=utf-8' })
end

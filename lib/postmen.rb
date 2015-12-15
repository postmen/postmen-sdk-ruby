$:.unshift File.dirname(__FILE__)

module Postmen
  class << self;
    attr_accessor :api_key
  end

  URL = ENV['POSTMEN_API_ENDPOINT'] || 'https://api.postmen.com'
end

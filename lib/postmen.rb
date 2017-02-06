require 'dry-configurable'
require 'dry-struct'
require 'http'
require 'json'
require 'pathname'
require 'forwardable'

require 'postmen/version'

class Postmen
  extend Dry::Configurable

  Error = Class.new(StandardError)
  RateLimitExceeded = Class.new(Error)
  ConnectionError = Class.new(Error)
  RequestError = Class.new(Error)

  setting :api_key, '77cb5493-a20a-45e4-9112-090b43337f97'
  setting :region, 'sandbox'
  setting :endpoint

  def self.endpoint
    config.endpoint || "https://#{self.config.region}-api.postmen.com/v3"
  end

  def self.root
    Pathname.new(File.expand_path(File.join(File.dirname(__FILE__), '../')))
  end
end

require 'postmen/types'
require 'postmen/connection'
require 'postmen/collection_proxy'
require 'postmen/label'
require 'postmen/label_collection'
require 'postmen/response'

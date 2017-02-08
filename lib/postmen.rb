require 'dry-configurable'
require 'dry-struct'
require 'http'
require 'json'
require 'pathname'
require 'forwardable'

require 'postmen/version'
require 'postmen/types'
require 'postmen/connection'
require 'postmen/collection_proxy'
require 'postmen/label'
require 'postmen/label_collection'
require 'postmen/response'
require 'postmen/query/label_query'

class Postmen
  extend Dry::Configurable

  Error = Class.new(StandardError)
  RateLimitExceeded = Class.new(Error)
  ConnectionError = Class.new(Error)
  RequestError = Class.new(Error)
  ResourceNotFound = Class.new(RequestError)

  setting :api_key, '77cb5493-a20a-45e4-9112-090b43337f97'
  setting :region, 'sandbox'
  setting :endpoint

  def self.endpoint
    config.endpoint || "https://#{config.region}-api.postmen.com/v3"
  end

  def self.root
    Pathname.new(File.expand_path(File.join(File.dirname(__FILE__), '../')))
  end
end

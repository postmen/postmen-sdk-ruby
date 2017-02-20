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
require 'postmen/address'
require 'postmen/parcel'
require 'postmen/shipment'
require 'postmen/passport'
require 'postmen/label'
require 'postmen/label_collection'
require 'postmen/response'
require 'postmen/query/label_query'
require 'postmen/query/create_label_query'

class Postmen
  extend Dry::Configurable

  Error = Class.new(StandardError)
  RateLimitExceeded = Class.new(Error)
  ConnectionError = Class.new(Error)
  RequestError = Class.new(Error)
  ResourceNotFound = Class.new(RequestError)

  setting :api_key
  setting :region
  setting :endpoint

  def self.endpoint
    config.endpoint || "https://#{config.region}-api.postmen.com/v3"
  end

  def self.root
    Pathname.new(File.expand_path(File.join(File.dirname(__FILE__), '../')))
  end
end

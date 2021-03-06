require 'dry-configurable'
require 'dry-struct'
require 'http'
require 'json'
require 'pathname'
require 'forwardable'

require 'postmen/version'
require 'postmen/errors'
require 'postmen/types'
require 'postmen/connection'
require 'postmen/collection_proxy'
require 'postmen/parcel'
require 'postmen/shipment'
require 'postmen/label'
require 'postmen/label_collection'
require 'postmen/response'
require 'postmen/query/label_query'
require 'postmen/query/create_label_query'
require 'postmen/query/rate_query'
require 'postmen/query/create_rate_query'
require 'postmen/rate_object'
require 'postmen/rate'
require 'postmen/rate_collection'
require 'postmen/shipper_account'
require 'postmen/shipper_account_collection'
require 'postmen/query/shipper_account_query'
require 'postmen/query/create_shipper_account_query'
require 'postmen/query/shipper_account_query'
require 'postmen/query/shipper_account_update_query'
require 'postmen/query/shipper_account_update_credentials_query'
require 'postmen/query/manifest_query'
require 'postmen/query/create_manifest_query'
require 'postmen/manifest'
require 'postmen/manifest_collection'
# This is the main class, it's being used as a namespace for all
# related classes and modules as well.
class Postmen
  extend Dry::Configurable

  # @#!attribute [rw] api_key [String] API key taken from the application.
  setting :api_key

  # @#!attribute [rw] region [String] Region - typically either 'sandbox' or 'production'
  setting :region

  # @#!attribute endpoint [String] Endoint name - specify if you'd like to use custom endpoint
  setting :endpoint

  # @#!attribute failover [Bool] Indicates if the SDK is using failover domain.
  setting :failover, false

  # Returns the endpoint used in all queries
  #
  # @return [String] endpoint url
  def self.endpoint
    config.endpoint || Connection.endpoint("#{config.region}-api", config.failover)
  end

  # Returns path where gem is installed
  #
  # @return [Pathname] path
  def self.root
    Pathname.new(File.expand_path(File.join(File.dirname(__FILE__), '../')))
  end

  # Checks wheter we're in failover mode
  def self.failover?
    !!config.failover
  end

  # Switch to failover domain
  def self.failover!
    config.failover = true
  end
end

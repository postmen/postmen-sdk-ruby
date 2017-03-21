class Postmen
  # Connection class is used to perform any HTTP connections,
  # it also does error handling.
  class Connection
    # Maximum number of retries
    MAX_REQUESTS = 5

    # Main domain used during normal usage.
    MAIN_DOMAIN = 'postmen.com'.freeze

    # Failover domain used during DNS issues with main domain
    FAILOVER_DOMAIN = 'postmen.net'.freeze

    def initialize
      @requests = 0
    end

    # Performs a HTTP GET request.
    #
    # @param path [String]
    # @param options [Hash]
    # @example
    #   .get('/labels')
    #   .get('/labels', { params: { limit: 5 } })
    def get(path, options = {})
      with_error_handling do
        Response.new(raw_get(path, options)).tap(&:parse_response!)
      end
    end

    # Performs a HTTP POST request.
    #
    # @param path [String]
    # @param options [Hash]
    # @example
    #   .post('/labels')
    #   .post('/labels', { json: { my: { sample: :data } } })
    def post(path, options = {})
      with_error_handling do
        Response.new(raw_post(path, options))
      end
    end

    # Performs a HTTP PUT request.
    #
    # @param path [String]
    # @param options [Hash]
    # @example
    #   .put('/shipper-accounts/123/info')
    #   ..put('/shipper-accounts/123/info', { json: { my: { sample: :data } } })
    def put(path, options = {})
      with_error_handling do
        Response.new(raw_put(path, options)).tap(&:parse_response!)
      end
    end

    # Performs a HTTP DELETE request
    #
    # @param path [String]
    # @example
    #   .delete('/shipper-accounts/11111')
    def delete(path)
      HTTP
        .headers(headers)
        .delete(get_full_url(path))
    end

    # Returns the endpoint used in SDK, based on the region(subdomain) and
    # a failover switch
    #
    # @param subdomain [String] The region/subdomain used.
    # @param failover [Boolean]
    def self.endpoint(subdomain, failover = false)
      URI::HTTPS.build(scheme: 'https',
                       host: hostname(subdomain, failover),
                       path: '/v3').to_s
    end

    # Returns the hostname based on the region(subdomain) and a failover switch
    #
    # @param subdomain [String] The region/subdomain used.
    # @param failover [Boolean]
    def self.hostname(subdomain, failover)
      base = failover ? FAILOVER_DOMAIN : MAIN_DOMAIN
      [subdomain, base].join('.')
    end

    private

    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/CyclomaticComplexity
    def with_error_handling
      raise ArgumentError unless block_given?

      begin
        yield
      # Rescue from any  connection issues
      rescue HTTP::ConnectionError
        # Raise error if we already tried to use failover domain
        raise if Postmen.failover?
        # Switch to failover domain & retry the request
        Postmen.failover!
        retry
      # Handle Rate limits.
      # Rate limits are being reset every 60 seconds - we're retrying
      # given request after that.
      # @see https://docs.postmen.com/ratelimit.html Documentation
      rescue RateLimitExceeded
        @requests += 1
        raise if @requests > MAX_REQUESTS
        sleep(60)
        retry
      # If the resource was not found, simply re-raise the exception
      rescue ResourceNotFound
        raise
      # Handle request errors.
      # Our current error handling policy depends on the error type.
      # If the API returns information, that the request is retriable,
      # We're waiting 5 seconds, and trying again with exact same request.
      # To prevent having infinite loops, we're trying maximum 5 times.
      # In case that we were unable to make successfull request with that 5 tries,
      # MaximumNumberOfRetriesReachedError is being raised.
      #
      # @raise RequestError if the request is not retriable
      # @raise MaximumNumberOfRetriesReachedError if the API returned error after 5 retries
      rescue RequestError => error
        raise unless error.retriable?
        raise MaximumNumberOfRetriesReachedError, self if @requests > MAX_REQUESTS
        @requests += 1
        sleep(5)
        retry
      end
    end

    def raw_get(path, options)
      HTTP
        .headers(headers)
        .get(get_full_url(path), options)
    end

    def raw_post(path, options)
      HTTP
        .headers(headers)
        .post(get_full_url(path), options)
    end

    def raw_put(path, options)
      HTTP
        .headers(headers)
        .put(get_full_url(path), options)
    end

    def get_full_url(path)
      [Postmen.endpoint, path].join
    end

    def headers
      {
        "content-type": 'application/json',
        "postmen-api-key": Postmen.config.api_key
      }
    end
  end
end

class Postmen
  # Connection class is used to perform any HTTP connections,
  # it also does error handling.
  class Connection
    # Maximum number of retries
    MAX_REQUESTS = 5

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
      Response.new(raw_get(path, options)).tap(&:parse_response!)
    rescue RateLimitExceeded
      @requests += 1
      raise if @requests > MAX_REQUESTS
      sleep(60)
      retry
    end

    # Performs a HTTP POST request.
    #
    # @param path [String]
    # @param options [Hash]
    # @example
    #   .post('/labels')
    #   .post('/labels', { json: { my: { sample: :data } } })
    def post(path, options = {})
      Response.new(raw_post(path, options))
    end

    # Performs a HTTP PUT request.
    #
    # @param path [String]
    # @param options [Hash]
    # @example
    #   .put('/shipper-accounts/123/info')
    #   ..put('/shipper-accounts/123/info', { json: { my: { sample: :data } } })
    def put(path, options = {})
      Response.new(raw_put(path, options))
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

    private

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
      debugger
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

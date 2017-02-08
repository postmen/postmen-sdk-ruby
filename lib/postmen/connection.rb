class Postmen
  class Connection
    MAX_REQUESTS = 5

    def initialize
      @requests = 0
    end

    def get(path, options = {})
      Response.new(raw_get(path, options)).tap(&:parse_response!)
    rescue RateLimitExceeded
      @requests += 1
      raise if @requests > MAX_REQUESTS
      sleep(60)
      retry
    end

    private

    def raw_get(path, options)
      HTTP
        .headers(headers)
        .get(get_full_url(path), options)
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

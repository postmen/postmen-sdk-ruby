class Postmen
  class Connection
    MAX_REQUESTS = 5

    def initialize
      @requests = 0
    end

    def get(path, options = {})
      begin
        Response.new(
          HTTP
            .headers(headers)
            .get(get_full_url(path))
        ).tap(&:ensure_rate_limit!)
      rescue RateLimitExceeded
        if true
          @requests += 1
          raise if @requests > MAX_REQUESTS
          sleep(1)
          retry
        end
      end
    end

    private
    def get_full_url(path)
      [Postmen.endpoint, path].join
    end

    def headers
      {
        "content-type": "application/json",
        "postmen-api-key": Postmen.config.api_key
      }
    end
  end
end

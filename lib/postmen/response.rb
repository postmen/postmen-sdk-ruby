class Postmen
  class Response < SimpleDelegator
    def parse_response!
      ensure_rate_limit!
      ensure_resource_found!
    end

    def meta
      @meta ||= parsed_response[:meta]
    end

    def parsed_response
      @parsed_response ||= JSON.parse(body, symbolize_names: true)
    end

    def rate_limit_exceeded?
      code == 429
    end

    def remaining_api_calls
      Integer(headers['X-RateLimit-Remaining'])
    end

    def api_rate_limit
      Integer(headers['X-RateLimit-Limit'])
    end

    def api_rate_limit_reset
      Integer(headers['X-RateLimit-Reset'])
    end

    def api_rate_limit_reset_at
      Time.at(api_rate_limit_reset)
    end

    private

    def ensure_rate_limit!
      raise RateLimitExceeded, self if rate_limit_exceeded?
    end

    def ensure_resource_found!
      raise ResourceNotFound, self if meta[:code] == 4153
    end
  end
end

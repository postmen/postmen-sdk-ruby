class Postmen
  # This class parses the HTTP response and checks if it was successfull.
  class Response < SimpleDelegator
    # Parses response.
    # Ensures that rate limit was not exceeded,
    # and checks if resource was found
    def parse_response!
      ensure_rate_limit!
      ensure_resource_found!
    end

    # Holds the meta data
    # @see https://docs.postmen.com/#meta API Documentation
    # @return [Hash]
    def meta
      @meta ||= parsed_response[:meta]
    end

    # Parses the json response
    # @return [Hash]
    def parsed_response
      @parsed_response ||= JSON.parse(body, symbolize_names: true)
    end

    # Checks if rate limit was exceeded
    def rate_limit_exceeded?
      code == 429
    end

    # Returns number of remaining API calls
    def remaining_api_calls
      Integer(headers['X-RateLimit-Remaining'])
    end

    # Returns current API rate limit
    def api_rate_limit
      Integer(headers['X-RateLimit-Limit'])
    end

    # Returns Unix timestamp when rate limit will be reset.
    # @return [Integer] timestamp
    def api_rate_limit_reset
      Integer(headers['X-RateLimit-Reset'])
    end

    # Return time when rate limit will be reset.
    # @return [Time]
    def api_rate_limit_reset_at
      Time.at(api_rate_limit_reset)
    end

    private

    # Guard method, checking if rate limit was not exceeded
    # @api private
    def ensure_rate_limit!
      raise RateLimitExceeded, self if rate_limit_exceeded?
    end

    # Guard method, checking if resource was found.
    # @api private
    def ensure_resource_found!
      raise ResourceNotFound, self if meta[:code] == 4153
    end
  end
end

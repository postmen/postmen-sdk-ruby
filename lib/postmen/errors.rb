class Postmen
  # Generic Exception class, all other exceptions should inherit from this class
  Error = Class.new(StandardError)

  # Generic exception raised if the API returns an error
  class RequestError < Error
    extend Forwardable

    def_delegators :@request, :meta, :data

    def initialize(request)
      @request = request
    end

    # Indicates whether request is retryable.
    # @see https://docs.postmen.com/errors.html API Documentation
    def retryable?
      meta.fetch(:retryable, false)
    end

    # Returns details for the request error
    # @see https://docs.postmen.com/#meta API Documentation
    def details
      meta[:details]
    end

    # Internal API error code
    # @see https://docs.postmen.com/errors.html List of Error codes
    def code
      meta[:code]
    end

    # Returns human-readable error message
    # @see https://docs.postmen.com/#meta API Documentation
    def message
      meta[:message]
    end

    private

    attr_reader :request
  end

  # Exception raised if rate limit was exceeded
  RateLimitExceeded = Class.new(Error)
  # Exception raised in case of any connection error
  ConnectionError = Class.new(Error)
  # Exception raised if retriable request reached maximum number of attempts.
  MaximumNumberOfRetriesReachedError = Class.new(Error)
  # Expcetion raised if resource was not found.
  ResourceNotFound = Class.new(RequestError)
end

class Postmen
  # This is a mixin used by all collections.
  # For an user perspective, every collection should
  # behave like a simple array of models.
  module CollectionProxy
    include Enumerable
    extend Forwardable

    # This module holds all class-level methods
    module ClassMethods
      # Settings hash. Used in model/key methods.
      attr_reader :settings

      # Sets (if argument is provided) or gets the model class name
      #
      # @return [Class] Model name, eg. `Label`
      def model(model = nil)
        return settings[:model] unless model
        settings[:model] = model
      end

      # Sets (if argument is provides) or gets the key where the data is being
      # searched in the API response.
      #
      # @see https://docs.postmen.com/#data API documentation
      # @return [Symbol] key name
      def key(key = nil)
        return settings[:key] unless key
        settings[:key] = key
      end

      # Wraps raw JSON response into an model
      #
      # @param response [Hash] parsed JSON response
      # @return model an instance of
      def get(response)
        model.new(response[:data])
      end
    end

    # Method called on base object when mixin gets included
    #
    # @private
    def self.included(base)
      base.extend ClassMethods
      base.instance_variable_set('@settings', {})
    end

    def_delegators :@data, :[], :each

    # Constructor
    # @param response [Hash] HTTP response, parsed by the Response class
    def initialize(response)
      @data = response[:data][self.class.key].map { |element| self.class.model.new(element) }
    end
  end
end

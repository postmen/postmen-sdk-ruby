class Postmen
  module CollectionProxy
    include Enumerable
    extend Forwardable

    module ClassMethods
      attr_reader :settings

      def model(model = nil)
        return settings[:model] unless model
        settings[:model] = model
      end

      def key(key = nil)
        return settings[:key] unless key
        settings[:key] = key
      end
    end

    def self.included(base)
      base.extend ClassMethods
      base.instance_variable_set('@settings', {})
    end

    def_delegators :@data, :[], :each

    def initialize(response)
      @data = response[:data][self.class.key].map{|element| self.class.model.new(element) }
    end
  end
end

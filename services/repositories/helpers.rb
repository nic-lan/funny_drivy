module Services
  module Repositories
    module Helpers
      attr_reader :data

      def initialize(data)
        @data = data.deep_symbolize_keys
      end
    end
  end
end

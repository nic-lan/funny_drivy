require "./serializers/worker"
require "./serializers/base"
require "./serializers/improved"

module Services
  class WorkersBuilder
    def self.create(serializer_attrs)
      new(serializer_attrs).create
    end

    attr_reader :serializer_attrs

    def initialize(serializer_attrs)
      @serializer_attrs = serializer_attrs
    end

    def create
      worker = ::Serializers::Worker.new(serializer_attrs)
      worker.extend serializer_map[serializer_key]
      worker
    end

    private

    def serializer_key
      serializer_attrs[:opts][:serializer]
    end

    def serializer_map
      { base: ::Serializers::Base, improved: ::Serializers::Improved }
    end
  end
end

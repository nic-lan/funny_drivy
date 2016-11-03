module Serializers
  class Collection
    def self.create(opts, serializers)
      new(opts, serializers).create
    end

    def initialize(opts, serializers)
      @opts = opts
      @serializers = serializers
    end

    attr_reader :serializers, :opts

    def create
      Hash[hash_key, serializers.map(&:as_json)]
    end

    private

    def hash_key
      "#{opts[:path]}s".to_sym
    end
  end
end

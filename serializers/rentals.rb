module Serializers
  class Rentals
    attr_reader :rental_serializers

    def initialize(rental_serializers)
      @rental_serializers = rental_serializers
    end

    def to_json
      as_json.to_json
    end

    private

    def as_json
      { rentals: rental_serializers.map(&:as_json) }
    end
  end
end

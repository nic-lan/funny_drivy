require "./services/repository"
require "./serializers/rentals"
require "./serializers/rental"
require "./models/price"

module Backend
  class Main
    def self.perform(data, discount: false)
      new(data, discount).perform
    end

    attr_reader :repo, :discount
    delegate :rentals_with_car_h, to: :repo

    def perform
      rentals.to_json
    end

    private

    def initialize(data, discount)
      @discount = discount
      @repo = Services::Repository.new(data)
    end

    def rentals
      Serializers::Rentals.new serializers
    end

    def serializers
      rentals_with_car_h.map do |rental_with_car_h|
        Serializers::Rental.new(serializer_attrs(rental_with_car_h))
      end
    end

    def serializer_attrs(rental_with_car_h)
      price_attrs = rental_with_car_h.merge(discount: discount)
      rental = rental_with_car_h[:rental]

      { rental: rental, price: Models::Price.new(price_attrs) }
    end
  end
end

require "./services/repository"
require "./serializers/rental"
require "./models/price"

module Backend
  class Main
    def self.perform(data, opts = { discount: false, commission: false })
      new(data, opts).perform
    end

    attr_reader :repo, :opts
    delegate :rentals_with_car, to: :repo

    def initialize(data, opts)
      @opts = opts
      @repo = Services::Repository.new(data)
    end

    def perform
      { rentals: rental_serializers.map(&:as_json) }.to_json
    end

    private

    def rental_serializers
      rentals_with_car.map do |rental_with_car|
        Serializers::Rental.new(
          rental: rental_with_car[:rental],
          price: ::Models::Price.new(rental_with_car, opts),
          opts: opts
        )
      end
    end
  end
end

require "./services/repository"
require "./controllers/workers_controller"
require "./models/price"

module Backend
  class Main
    DEFAULTS_OPTS = {
      discount: false, commission: false, deductible: false, serializer: :base
    }.freeze

    def self.perform(data, opts = {})
      new(data, DEFAULTS_OPTS.merge(opts)).perform
    end

    attr_reader :repo, :opts
    delegate :rentals, to: :repo

    def initialize(data, opts)
      @opts = opts
      @repo = Services::Repository.new(data)
    end

    def perform
      { rentals: rental_serializers.map(&:as_json) }.to_json
    end

    private

    def rental_serializers
      rentals.map { |rental| create_worker(rental) }
    end

    def create_worker(resource)
      Controllers::WorkersController.create(
        rental: resource.rental,
        price: ::Models::Price.new(resource, opts),
        opts: opts
      )
    end
  end
end

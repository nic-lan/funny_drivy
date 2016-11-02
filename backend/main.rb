require "./serializers/collection"
require "./controllers/workers_controller"
require "./services/repository"
require "./models/price"

module Backend
  class Main
    DEFAULTS_OPTS = {
      discount: false,
      commission: false,
      deductible: false,
      serializer: :base,
      path: :rentals
    }.freeze

    def self.perform(data, opts = {})
      new(data, DEFAULTS_OPTS.merge(opts)).perform
    end

    attr_reader :data, :opts

    def initialize(data, opts)
      @opts = opts
      @data = data
    end

    def perform
      Serializers::Collection.create(opts, rental_serializers).to_json
    end

    private

    def rentals
      Services::Repository.new(data).rentals
    end

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

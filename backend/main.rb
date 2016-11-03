require "./serializers/collection"
require "./services/workers_builder"
require "./services/repositories/rental"
require "./models/price"

module Backend
  class Main
    DEFAULTS_OPTS = {
      discount: false,
      commission: false,
      deductible: false,
      serializer: :base,
      path: :rental
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
      Serializers::Collection.create(opts, serializers).to_json
    end

    private

    def resources
      resource_repo_class.new(data).all
    end

    def resource_repo_class
      Object.const_get("Services::Repositories::#{opts[:path].to_s.camelize}")
    end

    def serializers
      resources.map { |rental| create_worker(rental) }
    end

    def create_worker(resource)
      Services::WorkersBuilder.create(
        priceable: resource.rental,
        price: ::Models::Price.new(resource, opts),
        opts: opts
      )
    end
  end
end

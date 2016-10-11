require "active_model"
require "./serializers/base"
require "./serializers/improved"

module Serializers
  class Worker
    class << self
      def setup(attrs)
        worker = new(attrs)
        worker.extend serializer(attrs[:opts])
        worker
      end

      private

      def serializer(opts)
        serializer_map[serializer_key(opts)]
      end

      def serializer_key(opts)
        return :base if opts[:serializer].nil?
        opts[:serializer]
      end

      def serializer_map
        { base: ::Serializers::Base, improved: ::Serializers::Improved }
      end
    end

    include ActiveModel::Model

    attr_accessor :rental, :price, :opts
    delegate :id, to: :rental
    delegate :value,
      :insurance_fee,
      :assistance_fee,
      :drivy_fee,
      :deductible_reduction,
      :opts,
      to: :price
  end
end

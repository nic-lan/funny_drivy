require "active_model"

module Serializers
  class Rental
    include ActiveModel::Model

    attr_accessor :rental, :price, :opts
    delegate :id, to: :rental

    def as_json
      opts[:commission] ? base_as_json.merge(commission_as_json) : base_as_json
    end

    private

    def base_as_json
      @_base ||= {
        id: id,
        price: price.value
      }
    end

    def commission_as_json
      {
        commission: {
          insurance_fee: price.insurance_fee,
          assistance_fee: price.assistance_fee,
          drivy_fee: price.drivy_fee
        }
      }
    end
  end
end

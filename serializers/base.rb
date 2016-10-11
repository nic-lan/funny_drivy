module Serializers
  module Base
    def as_json
      base_as_json.merge!(options_as_json).merge!(commission_as_json)
    end

    private

    def base_as_json
      @_base_as_json ||= { id: id, price: value }
    end

    def commission_as_json
      return {} unless opts[:commission]

      {
        commission: {
          insurance_fee: insurance_fee,
          assistance_fee: assistance_fee,
          drivy_fee: drivy_fee
        }
      }
    end

    def options_as_json
      return {} unless opts[:deductible]

      { options: { deductible_reduction: deductible_reduction } }
    end
  end
end

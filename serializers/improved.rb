module Serializers
  module Improved
    def as_json
      {
        id: id,
        actions: [
          { who: "driver", type: "debit", amount: driver },
          { who: "owner", type: "credit", amount: owner },
          { who: "insurance", type: "credit", amount: insurance_fee },
          { who: "assistance", type: "credit", amount: assistance_fee },
          { who: "drivy", type: "credit", amount: drivy }
        ]
      }
    end

    private

    def driver
      value + deductible_reduction
    end

    def drivy
      drivy_fee + deductible_reduction
    end

    def owner
      value - (insurance_fee + drivy_fee + assistance_fee)
    end

    def action(who:, type:, amount:)
      { who: who, type: type, amount: amount }
    end
  end
end
